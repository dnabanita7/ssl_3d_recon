nvcc = /usr/local/cuda/bin/nvcc
cudalib = /usr/local/cuda/lib64/
tensorflow = /home/naba/anaconda3/lib/python3.9/site-packages/tensorflow/include

all: src/chamfer_utils/tf_nndistance_so.so src/chamfer_utils/render_balls_so.so src/chamfer_utils/tf_auctionmatch_so.so
.PHONY : all

src/chamfer_utils/tf_nndistance_so.so: src/chamfer_utils/tf_nndistance_g.cu.o src/chamfer_utils/tf_nndistance.cpp
	g++ -std=c++17 src/chamfer_utils/tf_nndistance.cpp src/chamfer_utils/tf_nndistance_g.cu.o -o src/chamfer_utils/tf_nndistance_so.so -shared -fPIC -I $(tensorflow) -lcudart -L $(cudalib) -O2 -D_GLIBCXX_USE_CXX17_ABI=0

src/chamfer_utils/tf_nndistance_g.cu.o: src/chamfer_utils/tf_nndistance_g.cu
	$(nvcc) -D_GLIBCXX_USE_CXX17_ABI=0 -std=c++17 -c -o src/chamfer_utils/tf_nndistance_g.cu.o src/chamfer_utils/tf_nndistance_g.cu -I $(tensorflow) -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC -O2

src/chamfer_utils/render_balls_so.so: src/chamfer_utils/render_balls_so.cpp
	g++ -std=c++17 src/chamfer_utils/render_balls_so.cpp -o src/chamfer_utils/render_balls_so.so -shared -fPIC -O2 -D_GLIBCXX_USE_CXX17_ABI=0

src/chamfer_utils/tf_auctionmatch_so.so: src/chamfer_utils/tf_auctionmatch_g.cu.o src/chamfer_utils/tf_auctionmatch.cpp
	g++ -std=c++17 src/chamfer_utils/tf_auctionmatch.cpp src/chamfer_utils/tf_auctionmatch_g.cu.o -o src/chamfer_utils/tf_auctionmatch_so.so -shared -fPIC -I $(tensorflow) -lcudart -L $(cudalib) -O2 -D_GLIBCXX_USE_CXX17_ABI=0

src/chamfer_utils/tf_auctionmatch_g.cu.o: src/chamfer_utils/tf_auctionmatch_g.cu
	$(nvcc) -D_GLIBCXX_USE_CXX17_ABI=0 -std=c++17 -c -o src/chamfer_utils/tf_auctionmatch_g.cu.o src/chamfer_utils/tf_auctionmatch_g.cu -I $(tensorflow) -DGOOGLE_CUDA=1 -x cu -Xcompiler -fPIC -O2 -arch=sm_52
