#include <stdio.h>
#include <math.h>

#include <string>
#include <fstream>
#include <sstream>

#define SAMPLE_NUMBER_MAX 20000

typedef struct TrainingParams {
  int num_iterations;
  double learning_rate;
  double start_a;
  double start_b;
  int num_folds;
} TrainingParams;

typedef struct Sample {
  Sample(): x(0), t(0) {}
  double x;
  double t;
} Sample;

typedef struct Range {
  int start;
  int end;
} Range;


namespace {

int setup_folders(Range * const fold_list, int num_folds, int num_samples) {
  if (fold_list == NULL)
    return -1;

  int fold_size = num_samples/num_folds;
  int index = 0;
  for (int i=0;i<num_folds;++i) {
    fold_list[i].start = index;
    fold_list[i].end = index + fold_size - 1;
    index += fold_size;
  }
  fold_list[num_folds-1].end = num_samples-1;

  return 0;
}

void _read_line(std::ifstream &istream, std::string &text, double &value) {
  std::string line;
  std::getline(istream, line);
  std::istringstream istr(line);
  if (!(istr >> text >> value))
    throw "Reading line error";
}

int read_input_file(char const *file_name, TrainingParams * const params, 
                    Sample * const sample_list) {
  if (params == NULL || sample_list == NULL)
    return -1;
  std::ifstream stream(file_name, std::ifstream::in);
  if (!stream.is_open())
    return -1;
  
  try {
    double x, t;
    std::string title, line;
    for (int i=0;i<3;std::getline(stream, line), ++i);   // Read the traing header 
    _read_line(stream, title, x);
    params->num_iterations = (int)x;
    _read_line(stream, title, x);
    params->learning_rate = x;
    _read_line(stream, title, x);
    params->start_a = x;
    _read_line(stream, title, x);
    params->start_b = x;
    _read_line(stream, title, x);
    params->num_folds = (int)x;

    // Read the list of data sample
    int sample_count = 0;
    for (int i=0;i<3;std::getline(stream, line), ++i);   // Read the data samples header
    for (;std::getline(stream, line); ++sample_count) {
      std::istringstream istr(line);
      if (!(istr >> sample_list[sample_count].x >> sample_list[sample_count].t))
        throw "Reading sample list failed";
    }
    return sample_count;
  } catch (std::string &e) {
    fprintf(stderr, "%s\n", e.c_str());
    return -1;
  } catch (...) {
    fprintf(stderr, "::read_input_file -> Error while reading the input file\n");
    return -1;
  }

  return 0;
}

// Sample_set: is the set for a specific calculation
// Sample_set can be understood as references to elements in the sample list.
// Sample_list: is a list of all the samples
int find_sample_set(Sample const *sample_set[],
                    Sample const *sample_list, Range const *range) {
  int set_index = 0;
  for (int i=range->start;i <= range->end;++i) {
    sample_set[set_index] = &sample_list[i];
    set_index++;
  }
  return 0;
}
int find_complementary_sample_set(Sample const *sample_set[], Sample const *sample_list, 
                                  int num_samples, Range const *range) {
  int set_index = 0;
  for (int i=0;i<range->start;++i) {
    sample_set[set_index] = &sample_list[i];
    set_index++;
  }
  for (int i=range->end+1;i<num_samples;++i) {
    sample_set[set_index] = &sample_list[i];
    set_index++;
  }
  return 0;
}

}   // The end of anonymous namespace

namespace AssTest {

int test_input(TrainingParams const *params, Sample const *sample_list, int sample_count) {
  printf("Number of iteration is: %d\n", params->num_iterations);
  printf("Learning rate: %lf\n", params->learning_rate);
  printf("Start A: %lf\n", params->start_a);
  printf("Start B: %lf\n", params->start_b);
  printf("Number of folds: %d\n", params->num_folds);
  printf("Number of samples: %d\n", sample_count);

  for (int i=0;i<sample_count, i<10;++i) {
    printf("The %dth sample value: %10.10lf %10.10lf\n", i, sample_list[i].x, sample_list[i].t);
  }
  return 0;
}

}   // The end of AssTest namespace


namespace Ass {

TrainingParams params;

// Find the equation parameters by Gradien Descent algorithm
int find_equation_parameters(Sample const *sample_set[], int set_size, 
                             double *out_a, double *out_b) {
  double a = params.start_a;
  double b = params.start_b;
  for (int k=0;k<params.num_iterations;++k) {
    // Who cares to calculate y for every sample 
    // when expression (3) has it.
    
    // Find the gradient
    double da=0;
    double db=0;
    for (int i=0;i<set_size;++i) {
      db += (a*sample_set[i]->x + b - sample_set[i]->t);
      da += db*sample_set[i]->x;
    }

    // Standardize the gradient
    double size = sqrt(da*da + db*db);
    da = da/size;
    db = db/size;

    // Update P
    a = a - params.learning_rate*da;
    b = b - params.learning_rate*db;
  }

  *out_a = a;
  *out_b = b;

  return 0;
}

// Find the rmsd error
double find_rmsd_error(Sample const *sample_set[], int set_size, double a, double b) {
  double sum_square = 0;
  for (int i=0;i<set_size;++i) {
    double y = a*sample_set[i]->x + b - sample_set[i]->t;
    sum_square += y*y;
  }

  return sqrt(1/set_size * sum_square);
}

// Find the error frequency graph
double find_error_frequency_graph(Sample const *sample_set[], int set_size,
                                  double *out_graph) {
  // You can calculate the out_graph array 
  // using the definition in the description file
}

} // The end of Ass namespace


int main(int argc, char *argv[]) {
  // Read the input
  Sample *sample_list = new Sample[SAMPLE_NUMBER_MAX];
  int sample_count = ::read_input_file("assignment1.input.txt", &Ass::params, sample_list);
  if (sample_count < 0) {
    fprintf(stderr, "Input file doesn't satisfy the requirement, exit now\n");
    return -1;
  }
  //AssTest::test_input(&Ass::params, Ass::sample_list, Ass::sample_count);
  
  // Init the Sample folders
  Range *fold_list = new Range[Ass::params.num_folds];
  if (::setup_folders(fold_list, Ass::params.num_folds, sample_count)) {
    fprintf(stderr, "Can't setup the folders for sample list, exit now\n");
    return -1;
  }

  // Open output file
  FILE *out_stream = fopen("assignment1.output.txt", "w");
  if (!out_stream) {
    fprintf(stderr, "Can't open output file\n");
    return -1;
  }

  // Calculation
  for (int i=0;i<Ass::params.num_folds;i++) {
    // Init the TST & TRN set;
    int tst_size = fold_list[i].end - fold_list[i].start + 1;
    int trn_size = sample_count - tst_size;
    Sample **tst = new Sample*[tst_size];
    Sample **trn = new Sample*[trn_size];
    find_sample_set((Sample const **)tst, sample_list, &fold_list[i]);
    find_complementary_sample_set((Sample const **)trn, sample_list, 
                                   sample_count, &fold_list[i]);

    // Finding  the equation parameters
    double a,b;
    Ass::find_equation_parameters((Sample const **)trn, trn_size, &a, &b);

    // Find the rmsd error
    double rmsd_error = Ass::find_rmsd_error((Sample const **)tst, tst_size, a, b);

    // Find the error frequency graph
    double e_graph[10];
    for (int i=0;i<10;i++) e_graph[i] = 0;
    Ass::find_error_frequency_graph((Sample const **)tst, tst_size, e_graph);

    // Write the output 
    fprintf(out_stream,"%10.5f%10.5f%10.5f", a, b, rmsd_error);
    for (int i=0;i<10;++i)
      fprintf(out_stream,"%10.5f", e_graph[i]);
    fprintf(out_stream, "\n");

    delete[] tst;
    delete[] trn;
  }

  fclose(out_stream);
  delete[] sample_list;
  delete[] fold_list;
  return 0;
}
