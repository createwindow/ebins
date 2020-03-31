#include <iostream>
#include <string>
#include <sstream> //for istringstream

using namespace std;

const double live_call_audio_thousand_minites_price_b4_discount = 6;
const double live_call_video_thousand_minites_price_b4_discount = 24;
const double live_transcode_thousand_minites_price_b4_discount = 31;
const double chat_call_audio_thousand_minites_price_b4_discount = 6;

const double live_call_audio_thousand_minites_price_level_base = 6 * 0.3;
const double live_call_video_thousand_minites_price_level_base = 24 * 0.15;
const double live_transcode_thousand_minites_price_level_base = 31 * 0.19;
const double chat_call_audio_thousand_minites_price_level_base = 6 * 0.3;

const double live_call_audio_thousand_minites_price_level_50w = 6 * 0.25;
const double live_call_video_thousand_minites_price_level_50w = 24 * 0.125;
const double live_transcode_thousand_minites_price_level_50w = 31 * 0.16;
const double chat_call_audio_thousand_minites_price_level_50w = 6 * 0.25;

const double live_call_audio_thousand_minites_price_level_100w = 6 * 0.2;
const double live_call_video_thousand_minites_price_level_100w = 24 * 0.1;
const double live_transcode_thousand_minites_price_level_100w = 31 * 0.13;
const double chat_call_audio_thousand_minites_price_level_100w = 6 * 0.2;

enum LEVEL {
  LEVEL_NONE,
  LEVEL_BASE,
  LEVEL_50W,
  LEVEL_100W,
};




static double live_fee(LEVEL level,
                      double live_call_audio_thousand_minites,
                      double live_call_video_thousand_minites,
                      double live_transcode_thousand_minites) {
  double ret = 0.0;
  double live_call_audio_thousand_minites_price = live_call_audio_thousand_minites_price_b4_discount;
  double live_call_video_thousand_minites_price = live_call_video_thousand_minites_price_b4_discount;
  double live_transcode_thousand_minites_price = live_transcode_thousand_minites_price_b4_discount;

  switch (level) {
    case LEVEL_NONE:
    break;
    case LEVEL_BASE:
      live_call_audio_thousand_minites_price = live_call_audio_thousand_minites_price_level_base;
      live_call_video_thousand_minites_price = live_call_video_thousand_minites_price_level_base;
      live_transcode_thousand_minites_price = live_transcode_thousand_minites_price_level_base;
    break;
    case LEVEL_50W:
      live_call_audio_thousand_minites_price = live_call_audio_thousand_minites_price_level_50w;
      live_call_video_thousand_minites_price = live_call_video_thousand_minites_price_level_50w;
      live_transcode_thousand_minites_price = live_transcode_thousand_minites_price_level_50w;
    break;
    case LEVEL_100W:
      live_call_audio_thousand_minites_price = live_call_audio_thousand_minites_price_level_100w;
      live_call_video_thousand_minites_price = live_call_video_thousand_minites_price_level_100w;
      live_transcode_thousand_minites_price = live_transcode_thousand_minites_price_level_100w;
    break;
    default:
    break;
  }

  ret = live_call_audio_thousand_minites * live_call_audio_thousand_minites_price +
        live_call_video_thousand_minites * live_call_video_thousand_minites_price +
        live_transcode_thousand_minites  * live_transcode_thousand_minites_price;

  return ret;
}

static double chat_fee(LEVEL level,
                       double chat_call_audio_thousand_minites) {
  double ret = 0.0;
  double chat_call_audio_thousand_minites_price = chat_call_audio_thousand_minites_price_b4_discount;

  switch (level) {
    case LEVEL_NONE:
    break;
    case LEVEL_BASE:
      chat_call_audio_thousand_minites_price = chat_call_audio_thousand_minites_price_level_base;
    break;
    case LEVEL_50W:
      chat_call_audio_thousand_minites_price = chat_call_audio_thousand_minites_price_level_50w;
    break;
    case LEVEL_100W:
      chat_call_audio_thousand_minites_price = chat_call_audio_thousand_minites_price_level_100w;
    break;
    default:
    break;
  }
  
  ret = chat_call_audio_thousand_minites * chat_call_audio_thousand_minites_price;

  return ret;
}

static double total_fee(LEVEL level,
                        double live_call_audio_thousand_minites,
                        double live_call_video_thousand_minites,
                        double live_transcode_thousand_minites,
                        double chat_call_audio_thousand_minites) {
  double ret = 0.0;
  
  double live = live_fee(level,
                         live_call_audio_thousand_minites,
                         live_call_video_thousand_minites,
                         live_transcode_thousand_minites);

  double chat = chat_fee(level,
                         chat_call_audio_thousand_minites);

  return live + chat;
}


static double actual_fee(double live_call_audio_thousand_minites,
                         double live_call_video_thousand_minites,
                         double live_transcode_thousand_minites,
                         double ttt_chat_call_audio_thousand_minites) {

  double ret = total_fee(LEVEL_NONE, 
                         live_call_audio_thousand_minites,
                         live_call_video_thousand_minites,
                         live_transcode_thousand_minites,
                         ttt_chat_call_audio_thousand_minites);
  cout << "\nBefore discount! Total fee is " << ret << endl;

  double total;
  if (ret > 1000000) {
    double live = live_fee(LEVEL_100W,
                           live_call_audio_thousand_minites,
                           live_call_video_thousand_minites,
                           live_transcode_thousand_minites);
    cout << "Level 100w, Live fee: " << live << endl;
    double chat = chat_fee(LEVEL_100W,
                           ttt_chat_call_audio_thousand_minites);
    cout << "Level 100w, Chat fee: " << chat << endl;
    total = live + chat;
    cout << "Level 100w, Total fee: " << total << endl;
  } else if (ret > 500000) {

    double live = live_fee(LEVEL_50W,
                           live_call_audio_thousand_minites,
                           live_call_video_thousand_minites,
                           live_transcode_thousand_minites);
    cout << "Level 50w, Live fee: " << live;
    double chat = chat_fee(LEVEL_50W,
                           ttt_chat_call_audio_thousand_minites);
    cout << "Level 50w, Chat fee: " << chat << endl;
    total = live + chat;
    cout << "Level 50w, Total fee: " << total << endl;
  } else {
    double live = live_fee(LEVEL_BASE,
                           live_call_audio_thousand_minites,
                           live_call_video_thousand_minites,
                           live_transcode_thousand_minites);
    cout << "Level Base, Live fee: " << live << endl;
    double chat = chat_fee(LEVEL_BASE,
                           ttt_chat_call_audio_thousand_minites);
    cout << "Level Base, Chat fee: " << chat << endl;
    total = live + chat;
    cout << "Level Base, Total fee: " << total << endl;
  }

  return total;
}

static double month_fee(double *live_call_audio_thousand_minites,
                     double *live_call_video_thousand_minites,
                     double *live_transcode_thousand_minites,
                     double *chat_call_audio_thousand_minites,
                     double live_inc,
                     double chat_inc,
                     double zorro) {
  *live_call_audio_thousand_minites  *= (1 + live_inc);
  *live_call_video_thousand_minites *= (1 + live_inc);
  *live_transcode_thousand_minites *= (1 + live_inc);
  *chat_call_audio_thousand_minites *= (1 + chat_inc);
  double ttt_chat_call_audio_thousand_minites = *chat_call_audio_thousand_minites * (1 - zorro);

    cout << "live_call_audio_thousand_minites: " << *live_call_audio_thousand_minites << endl
         << "live_call_video_thousand_minites: " << *live_call_video_thousand_minites << endl
         << "live_transcode_thousand_minites: "  << *live_transcode_thousand_minites << endl
         << "chat_call_audio_thousand_minites: " << *chat_call_audio_thousand_minites << endl
         << "zorro: " << zorro << endl
         << "ttt_chat_call_audio_thousand_minites: " << ttt_chat_call_audio_thousand_minites << endl
         << "live_inc: " << live_inc << endl
         << "chat_inc: " << chat_inc << endl;

  double if_no_zorro = actual_fee(*live_call_audio_thousand_minites,
                                  *live_call_video_thousand_minites,
                                  *live_transcode_thousand_minites,
                                  *chat_call_audio_thousand_minites);

  double ret = actual_fee(*live_call_audio_thousand_minites,
                          *live_call_video_thousand_minites,
                          *live_transcode_thousand_minites,
                          ttt_chat_call_audio_thousand_minites);

  cout << "zorro saving: " << (if_no_zorro - ret) << endl;

  return ret;
}


int main(int argc, char* argv[])
{
  double live_call_audio_thousand_minites;
  double live_call_video_thousand_minites;
  double live_transcode_thousand_minites;
  double chat_call_audio_thousand_minites;
  double live_inc = 0.0;
  double chat_inc = 0.0;
  double zorro = 0.0;
  int month = 1;

  if (argc == 2) {
    string arg;
    istringstream istrStream(argv[1]);
    istrStream >> arg;
    cout << "Help: " << endl
         << " live_call_audio_thousand_minites; " << endl
         << " live_call_video_thousand_minites; " << endl
         << " live_transcode_thousand_minites; " << endl
         << " chat_call_audio_thousand_minites; " << endl
         << " live_inc; " << endl
         << " chat_inc; " << endl
         << " zorro_percent; " << endl
         << " month; " << endl;
    return 0;
  }

  if (argc < 5) {
    cout << "ERROR: not enough arguments, at least 4 required." << endl;
    return -1;
  }

  for (int i = 0; i < argc; ++i) {
    istringstream istrStream(argv[i]);
    if (i == 1) {
      istrStream >> live_call_audio_thousand_minites;
    } else if (i == 2) {
      istrStream >> live_call_video_thousand_minites;
    } else if (i == 3) {
      istrStream >> live_transcode_thousand_minites;
    } else if (i == 4) {
      istrStream >> chat_call_audio_thousand_minites;
    }
  }

  if (argc > 5) {
    for (int i = 5; i < argc; ++i) {
      istringstream istrStream(argv[i]);
      if (i == 5) {
        istrStream >> live_inc;
      } else if (i == 6) {
        istrStream >> chat_inc;
      } else if (i == 7) {
        istrStream >> zorro;
      } else if (i == 8) {
        istrStream >> month;
      }
    }
  }

	cout.setf(ios::fixed,ios::floatfield); //十进制计数法，不是科学计数法
	cout.precision(2); //保留2位小数
  
  cout << "live_call_audio_thousand_minites: " << live_call_audio_thousand_minites << endl
       << "live_call_video_thousand_minites: " << live_call_video_thousand_minites << endl
       << "live_transcode_thousand_minites: "  << live_transcode_thousand_minites << endl
       << "chat_call_audio_thousand_minites: " << chat_call_audio_thousand_minites << endl
       << "zorro: " << zorro << endl
       << "live_inc: " << live_inc << endl
       << "chat_inc: " << chat_inc << endl
       << "month: " << month << endl;

  for (int i = 0; i < month; ++i) {
    cout << "\n============== Month " << i << "==============" << endl;
    double ttt_chat_call_audio_thousand_minites = chat_call_audio_thousand_minites * (1 - zorro);
    double z = zorro + i * 0.15;
    // if (z > 0.7) {
      // z = 0.7;
    // }

    double l_inc = live_inc;
    double c_inc = chat_inc;
    if (i == 0) {
      l_inc = 0.0;
      c_inc = 0.0;
    }
    month_fee(&live_call_audio_thousand_minites,
              &live_call_video_thousand_minites,
              &live_transcode_thousand_minites,
              &chat_call_audio_thousand_minites,
              l_inc,
              c_inc,
              z);
  }

  return 0;
}

