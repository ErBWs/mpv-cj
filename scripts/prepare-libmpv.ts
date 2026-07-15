/*
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

import { createHash } from 'crypto';
import { execFile } from 'child_process';
import { createWriteStream } from 'fs';
import { access, mkdir, readFile, rm } from 'fs/promises';
import { get } from 'https';
import { join, resolve } from 'path';

const LIBMPV_URL = 'https://github.com/mpv-ohos/libmpv-ohos-build/releases/download/20260715/libmpv_aarch64.zip';
const LIBMPV_SHA256 = 'ac8b176dc4c86f4772d62ff530762ec187c3c46383bf2d476870d17dad806e5b';
const MAX_REDIRECTS = 5;

async function exists(filePath: string): Promise<boolean> {
    try {
        await access(filePath);
        return true;
    } catch {
        return false;
    }
}

async function sha256(filePath: string): Promise<string> {
    const content = await readFile(filePath);
    return createHash('sha256').update(content).digest('hex');
}

function download(url: string, output: string, redirects: number = MAX_REDIRECTS): Promise<void> {
    return new Promise<void>((resolveDownload, rejectDownload) => {
        const request = get(url, response => {
            const statusCode = response.statusCode ?? 0;
            const location = response.headers.location;

            if (statusCode >= 300 && statusCode < 400 && location !== undefined) {
                response.resume();
                if (redirects === 0) {
                    rejectDownload(new Error(`Too many redirects while downloading ${url}`));
                    return;
                }
                const redirectUrl = new URL(location, url).toString();
                download(redirectUrl, output, redirects - 1).then(resolveDownload, rejectDownload);
                return;
            }

            if (statusCode !== 200) {
                response.resume();
                rejectDownload(new Error(`Failed to download ${url}: HTTP ${statusCode}`));
                return;
            }

            const file = createWriteStream(output);
            response.pipe(file);
            file.on('finish', () => {
                file.close(() => resolveDownload());
            });
            file.on('error', error => {
                response.destroy();
                rejectDownload(error);
            });
        });

        request.on('error', rejectDownload);
    });
}

function extract(source: string, destination: string): Promise<void> {
    let command = 'unzip';
    let args = ['-o', source, '-d', destination];

    if (process.platform === 'win32') {
        command = 'powershell.exe';
        args = [
            '-NoProfile',
            '-NonInteractive',
            '-Command',
            '& { param($source, $destination) Expand-Archive -LiteralPath $source -DestinationPath $destination -Force }',
            source,
            destination
        ];
    }

    return new Promise<void>((resolveExtract, rejectExtract) => {
        execFile(command, args, error => {
            if (error === null) {
                resolveExtract();
            } else {
                rejectExtract(error);
            }
        });
    });
}

export async function prepareLibmpv(moduleDir: string): Promise<void> {
    const archive = resolve(moduleDir, 'libmpv_aarch64.zip');
    const destination = resolve(moduleDir, 'libs', 'arm64-v8a');

    if (await exists(archive)) {
        if (await sha256(archive) !== LIBMPV_SHA256) {
            await rm(archive);
        }
    }

    if (!await exists(archive)) {
        console.log(`Downloading ${LIBMPV_URL}`);
        await download(LIBMPV_URL, archive);

        if (await sha256(archive) !== LIBMPV_SHA256) {
            throw new Error(`SHA-256 verification failed for ${archive}`);
        }

        await mkdir(destination, { recursive: true });
        await extract(archive, destination);
    }
}
