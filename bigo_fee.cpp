#include <iostream>
#include <string>
#include <sstream> //for istringstream

using namespace std;

const double live_call_audio_thousand_minites_price_b4_discount = 6;
const double live_call_video_thousand_minites_price_b4_discount = 22;
const double live_transcode_thousand_minites_price_b4_discount = 27;
const double chat_call_audio_thousand_minites_price_b4_discount = 6;

const double live_call_audio_thousand_minites_price_level_base = 6 * 0.192;
const double live_call_video_thousand_minites_price_level_base = 22 * 0.117;
const double live_transcode_thousand_minites_price_level_base = 27 * 0.157;
const double chat_call_audio_thousand_minites_price_level_base = 6 * 0.192;

const double live_call_audio_thousand_minites_price_level_50w = 6 * 0.160;
const double live_call_video_thousand_minites_price_level_50w = 22 * 0.097;
const double live_transcode_thousand_minites_price_level_50w = 27 * 0.131;
const double chat_call_audio_thousand_minites_price_level_50w = 6 * 0.160;

const double live_call_audio_thousand_minites_price_level_100w = 6 * 0.133;
const double live_call_video_thousand_minites_price_level_100w = 22 * 0.081;
const double live_transcode_thousand_minites_price_level_100w = 27 * 0.109;
const double chat_call_audio_thousand_minites_price_level_100w = 6 * 0.133;

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
                         double bigo_chat_call_audio_thousand_minites) {

  double ret = total_fee(LEVEL_NONE, 
                         live_call_audio_thousand_minites,
                         live_call_video_thousand_minites,
                         live_transcode_thousand_minites,
                         bigo_chat_call_audio_thousand_minites);
  cout << "Before discount! Total fee is " << ret << endl;

  double total;
  cout << "After discount: " << ret << endl;
  if (ret > 1000000) {
    double live = live_fee(LEVEL_100W,
                           live_call_audio_thousand_minites,
                           live_call_video_thousand_minites,
                           live_transcode_thousand_minites);
    cout << "Level 100w, Live fee: " << live << endl;
    double chat = chat_fee(LEVEL_100W,
                           bigo_chat_call_audio_thousand_minites);
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
                           bigo_chat_call_audio_thousand_minites);
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
                           bigo_chat_call_audio_thousand_minites);
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
                     double zorro,
                     double zorro_live,
                     double *zorro_saving) {
  *live_call_audio_thousand_minites  *= (1 + live_inc);
  *live_call_video_thousand_minites *= (1 + live_inc);
  *live_transcode_thousand_minites *= (1 + live_inc);
  *chat_call_audio_thousand_minites *= (1 + chat_inc);
  double bigo_chat_call_audio_thousand_minites = *chat_call_audio_thousand_minites * (1 - zorro_live);

  double bigo_live_call_audio_thousand_minites = *live_call_audio_thousand_minites * (1 - zorro_live);
  double bigo_live_call_video_thousand_minites = *live_call_video_thousand_minites * (1 - zorro_live);
  double bigo_live_transcode_thousand_minites = *live_transcode_thousand_minites * (1 - zorro_live);

  cout << "live_call_audio_thousand_minites: " << *live_call_audio_thousand_minites << endl
       << "live_call_video_thousand_minites: " << *live_call_video_thousand_minites << endl
       << "live_transcode_thousand_minites: "  << *live_transcode_thousand_minites << endl
       << "chat_call_audio_thousand_minites: " << *chat_call_audio_thousand_minites << endl
       << "zorro: " << zorro << endl
       << "zorro_live: " << zorro_live << endl
       << "bigo_chat_call_audio_thousand_minites: " << bigo_chat_call_audio_thousand_minites << endl
       << "bigo_live_call_audio_thousand_minites: " << bigo_live_call_audio_thousand_minites << endl
       << "bigo_live_call_video_thousand_minites: " << bigo_live_call_video_thousand_minites << endl
       << "bigo_live_transcode_thousand_minites: " << bigo_live_transcode_thousand_minites << endl
       << "live_inc: " << live_inc << endl
       << "chat_inc: " << chat_inc << endl;

  cout << "\n---==== Without ZORRO ====---" << endl;
  double if_no_zorro = actual_fee(*live_call_audio_thousand_minites,
                                  *live_call_video_thousand_minites,
                                  *live_transcode_thousand_minites,
                                  *chat_call_audio_thousand_minites);

  cout << "\n---==== Using ZORRO ====---" << endl;
  double ret = actual_fee(bigo_live_call_audio_thousand_minites,
                          bigo_live_call_video_thousand_minites,
                          bigo_live_transcode_thousand_minites,
                          bigo_chat_call_audio_thousand_minites);

  *zorro_saving = if_no_zorro - ret;
  cout << "zorro saving: " << *zorro_saving << endl;

  return ret;
}


int main(int argc, char* argv[])
{
  double live_call_audio_thousand_minites;
  double live_call_video_thousand_minites;
  double live_transcode_thousand_minites;
  double chat_call_audio_thousand_minites_zorro;
  double chat_call_audio_thousand_minites_bigo;
  double chat_call_audio_thousand_minites;
  double live_inc = 0.0;
  double chat_inc = 0.0;
  double zorro = 0.0;
  double zorro_live = 0.0;
  int start_zorro_live_month_index = 1;
  int month = 1;
  int start_month_index = 1;

  if (argc <= 2) {
    cout << "Help: " << endl
         << " live_call_audio_thousand_minites; " << endl
         << " live_call_video_thousand_minites; " << endl
         << " live_transcode_thousand_minites; " << endl
         << " chat_call_audio_thousand_minites_bigo; " << endl
         << " chat_call_audio_thousand_minites_zorro; " << endl
         << " live_inc; " << endl
         << " chat_inc; " << endl
         << " zorro_live_start_percent; " << endl
         << " zorro_live_start_month_index (-1, disable); " << endl
         << " month; " << endl
         << " start_month_index; " << endl;
    return 0;
  }

  if (argc == 3) {
    int chat_call_audio_thousand_minites_zorro;
    int chat_call_audio_thousand_minites_bigo;
    istringstream istrStream1(argv[1]);
    istrStream1 >> chat_call_audio_thousand_minites_zorro;
    istringstream istrStream2(argv[2]);
    istrStream2 >> chat_call_audio_thousand_minites_bigo;

    double partition = chat_call_audio_thousand_minites_zorro * 1.0 / 
        (chat_call_audio_thousand_minites_zorro + chat_call_audio_thousand_minites_bigo);

    cout << " chat_call_audio_thousand_minites_zorro: " << chat_call_audio_thousand_minites_zorro << endl
         << " chat_call_audio_thousand_minites_bigo: " << chat_call_audio_thousand_minites_bigo << endl
         << " partition: " << partition << endl;
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
      istrStream >> chat_call_audio_thousand_minites_bigo;
    } else if (i == 5) {
      istrStream >> chat_call_audio_thousand_minites_zorro;
    }
  }

  chat_call_audio_thousand_minites =
      chat_call_audio_thousand_minites_bigo + chat_call_audio_thousand_minites_zorro;
  if (chat_call_audio_thousand_minites != 0) {
    zorro = chat_call_audio_thousand_minites_zorro / chat_call_audio_thousand_minites;
  } else {
    zorro = 0.0;
  }
  if (argc > 6) {
    for (int i = 6; i < argc; ++i) {
      istringstream istrStream(argv[i]);
      if (i == 6) {
        istrStream >> live_inc;
      } else if (i == 7) {
        istrStream >> chat_inc;
      } else if (i == 8) {
        istrStream >> zorro_live;
      } else if (i == 9) {
        istrStream >> start_zorro_live_month_index;
      } else if (i == 10) {
        istrStream >> month;
      } else if (i == 11) {
        istrStream >> start_month_index;
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
       << "zorro_live_start_percent: " << zorro_live << endl
       << "live_inc: " << live_inc << endl
       << "chat_inc: " << chat_inc << endl
       << "start_zorro_live_month_index: " << start_zorro_live_month_index << endl
       << "month: " << month << endl
       << "start_month_index: " << start_month_index << endl;

  double total = 0.0;
  double zorro_saving = 0.0;
  for (int i = 0; i < month; ++i) {
    cout << "\n============== Month " << start_month_index + i << "==============" << endl;
    // double bigo_chat_call_audio_thousand_minites = chat_call_audio_thousand_minites * (1 - zorro);
    double z = zorro + i * 0.15;
    double z_live = 0.0;
    double z_saving = 0.0;
    double one_month_fee = 0.0;
    if (start_zorro_live_month_index != -1 && start_month_index + i >= start_zorro_live_month_index) {
      z_live = zorro_live + (start_month_index + i - start_zorro_live_month_index + 1) * 0.00;
    }
    if (z_live > 0.9) {
      z_live = 0.9;
    }

    double l_inc = live_inc;
    double c_inc = chat_inc;
    if (i == 0) {
      l_inc = 0.0;
      c_inc = 0.0;
    }
    one_month_fee = month_fee(&live_call_audio_thousand_minites,
                              &live_call_video_thousand_minites,
                              &live_transcode_thousand_minites,
                              &chat_call_audio_thousand_minites,
                              l_inc,
                              c_inc,
                              z,
                              z_live,
                              &z_saving);
    total += one_month_fee;
    zorro_saving += z_saving;
  }


  cout << "\nTotal fee for " << month << ": " << total << " average: " << total / month << endl;
  cout << "\nTotal saving fee for " << month << ": " << zorro_saving << " average: " << zorro_saving / month << endl;

  return 0;
}

