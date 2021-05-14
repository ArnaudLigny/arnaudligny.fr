const path = require('path');

const getCacheDirs = (constants, inputs) => [
  constants.PUBLISH_DIR,
  inputs.cacheDir || env.CECIL_CACHE_DIR || '.cache'
];

module.exports = {
  async onPreBuild({constants, inputs, utils}) {
    if (process.cwd() === constants.PUBLISH_DIR) {
      utils.build.failBuild(
        `Your site’s publish directory is not set correctly (“${constants.PUBLISH_DIR}”).`
      );
    }

    const cacheDirs = getCacheDirs(constants, inputs);

    if (await utils.cache.restore(cacheDirs)) {

      // test
      utils.status.show({
        title: 'Cache',
        summary: 'Cecil cache restored from previous build.',
        text: cacheDirs.join(', ')
      })

      console.log('Found the Cecil cache (in "%s").', cacheDirs.join(', '));
    } else {
      console.log('Cecil cache not found.');
    }
  },
  async onPostBuild({constants, inputs, utils}) {
    const cacheDirs = getCacheDirs(constants, inputs);

    if (await utils.cache.save(cacheDirs)) {
      console.log('Stored the Cecil cache (from "%s") to speed up next builds.', cacheDirs.join(', '));
    } else {
      console.log('No Cecil build found.');
    }
  },
};
