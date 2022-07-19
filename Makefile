##  sous ubuntu install libsuitesparse-dev package
#  comment or decommet les lignes
#  ubuntu
#BLASLIBS= -lblas
#BLASINC= -DWITHBLAS
#UMFPACKINC = -I/usr/include/suitesparse/
#UMFPACKLIBS = -L/usr/lib/x86_64-linux-gnu/ -lumfpack -lamd
#  macos install avec brew
#BLASLIBS= -framework Accelerate
BLASINC= -DWITHBLAS #-framework Accelerate
UMFPACKINC= -I/usr/local/include
UMFPACKLIBS= -L/usr/local/lib -lumfpack  -lcholmod -lccolamd -lcolamd -lcamd -lamd -lsuitesparseconfig $(BLASLIBS)
#  macos install a  avec MKL

DIR_UMFPACK= /usr/local
UMFPACKINC = -I$(DIR_UMFPACK)/include
UMFPACKLIBS = -L$(DIR_UMFPACK)/lib -lumfpack  -lcholmod  -lccolamd -lcolamd -lcamd -lamd -lsuitesparseconfig $(BLASLIBS)
#BLASLIBS= -framework  Accelerate  # MacOs

#BLASLIBS= -L/opt/intel/mkl/lib/ -lmkl_rt -lmkl_sequential -lmkl_core   -liomp5 -lpthread
#UMFPACKINC= -I/Users/hecht/work/ff++/download/include
#UMFPACKLIBS= -L/Users/hecht/work/ff++/download/lib

CXXCHECK = -g -O0 #-fsanitize=address -fno-optimize-sibling-calls #  verification avec clang++
CXXOPT =  -O3

CXXFLAGS =  $(CXXOPT) -Wall -std=c++11 $(UMFPACKINC)
CXXFLAGS += -MMD -MP
PROGS =  mainlapP1 mainlapP2 mainStokesP2P2P0	mainStokesP2P1 check41 check421 check422 check43
OBJS  = EF2d-base.o   QuadratureFormular.o EF2d.o SparseLinearSolver.o CG.o
SRC = EF2d-base.cpp   QuadratureFormular.cpp EF2d.cpp SparseLinearSolver.cpp CG.cpp mainlapP1.cpp mainlapP2.cpp mainStokesP2P2P0.cpp mainStokesP2P1.cpp check41.cpp check421.cpp check422.cpp check43.cpp
all: $(PROGS)

-include $(SRC:%.cpp=%.d)

mainlapP1:mainlapP1.o $(OBJS)
	$(CXX) -o $@ $^  $(CXXFLAGS) $(BLASLIBS) $(UMFPACKLIBS)
mainlapP2:mainlapP2.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(BLASLIBS) $(UMFPACKLIBS)
mainStokesP2P1:mainStokesP2P1.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(BLASLIBS) $(UMFPACKLIBS)
mainStokesP2P2P0:mainStokesP2P2P0.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(BLASLIBS) $(UMFPACKLIBS)
check41:check41.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(BLASLIBS) $(UMFPACKLIBS)
check421:check421.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(BLASLIBS) $(UMFPACKLIBS)
check422:check422.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(BLASLIBS) $(UMFPACKLIBS)
check43:check43.o $(OBJS)
	$(CXX) -o $@ $^ $(CXXFLAGS) $(BLASLIBS) $(UMFPACKLIBS)


clean:
	-rm $(PROGS) *.o *~  *.txt *.exe *.d
