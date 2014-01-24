rm -rf dist/*
cp -R build/* dist/
cp node_modules/Phaser/build/phaser.min.js dist/
cp index-dist.html dist/index.html
cp -R assets dist/

