#include <iostream>

using namespace std;

int main(int argc, char* argv[]) {
  double s0, s1, s2, s3, s4;
  s1 = s2 = s3 = s4 = 0.0;

  switch (argc) {
    case 5:
      s0 = atof(argv[argc - 4]);
      cout << "s0: " << s0 << endl;
    case 4:
      s1 = atof(argv[argc - 3]);
      cout << "s1: " << s1 << endl;
    case 3:
      s2 = atof(argv[argc - 2]);
      cout << "s2: " << s2 << endl;
    case 2:
      s3 = atof(argv[argc - 1]);
      cout << "s3: " << s3 << endl;
      break;
    default:
      break;
  }

  double first3season = s1 + s2 + s3;
  const double kFirst3SeasonFactor = 0.4;
  const double kLastSeasonFactor = 0.6;
  const double kA = 4.5;
  const double kB = 3.5;

  double point2GetA = (kA - first3season * kFirst3SeasonFactor / (argc - 1)) / kLastSeasonFactor;
  cout << "Last Season Score to A: " << point2GetA << endl;
  
  if (argc == 5) {
    cout << "Annual Score: " << (s0 + s1 + s2) / 3 * 0.4 + s3 * 0.6 << endl;
  }
  
  return 0;
}
