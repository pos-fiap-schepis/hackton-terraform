module.exports = {
    writerOpts: {
        transform: (commit) => {
            // Include only "docs" type commits
            if (commit.type !== 'docs') {
                return null;
            }
            return commit;
        },
    },
};