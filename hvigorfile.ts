/*
 * Copyright (C) 2026. Bao Han <erbws@qq.com>
 */

import { harTasks } from '@ohos/hvigor-ohos-plugin';
import { getNode, hvigor } from '@ohos/hvigor';
import { prepareLibmpv } from './scripts/prepare-libmpv';

const node = getNode(__filename);

hvigor.nodesEvaluated(() => {
    node.registerTask({
        name: 'prepareLibmpv',
        async run(): Promise<void> {
            await prepareLibmpv(__dirname);
        },
        postDependencies: ['default@PreBuild']
    });
});

export default {
    system: harTasks,  /* Built-in plugin of Hvigor. It cannot be modified. */
    plugins:[]         /* Custom plugin to extend the functionality of Hvigor. */
}
