rm -rf ./build
rm -rf ./debug
rm -rf ./release

cmake CMakeLists.txt -B ./build

mkdir debug
cd debug
cmake -DCMAKE_BUILD_TYPE=Debug ..
cd ..

mkdir release
cd release
cmake -DCMAKE_BUILD_TYPE=Release ..
cd ..

gtags
