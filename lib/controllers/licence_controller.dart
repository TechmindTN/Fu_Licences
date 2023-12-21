// ignore_for_file: prefer_interpolation_to_compose_strings, non_constant_identifier_names
import 'dart:developer';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:fu_licences/models/version.dart';
import 'package:fu_licences/screens/licence/searched_licences_list.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/models/Stats.dart';
import 'package:fu_licences/models/coach.dart';
import 'package:fu_licences/models/full_licence.dart';
import 'package:fu_licences/models/licence.dart';
import 'package:fu_licences/models/parameters.dart';
import 'package:fu_licences/models/user.dart';
import 'package:fu_licences/network/apis.dart';
import 'package:fu_licences/network/licence_network.dart';
import 'package:fu_licences/screens/auth/login_Screen.dart';
import 'package:fu_licences/screens/home/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_windows/image_picker_windows.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as p;
import '../models/arbitrator.dart';
import '../models/athlete.dart';
import '../models/category.dart';
import '../models/club.dart';
import '../models/degree.dart';
import '../models/discipline.dart';
import '../models/grade.dart';
import '../models/ligue.dart';
import '../models/profile.dart';
import '../models/role.dart';
import '../models/season.dart';
import '../models/weight.dart';
import '../router/routes.dart';
import '../widgets/global/snackbars.dart';
import '../widgets/licence/licence_widget.dart';

class LicenceProvider extends ChangeNotifier {
   List<Club> NonDefaultClubs=[];
  int currentPage = 1;
  Version currentVersion = Version(version: "0.21");
  bool logged = false;
  bool isAscending = true;
  int currentSortColumn = 0;
  late Category autoCategory;
  List<bool> licenceChecks = [];
  List<bool> clubChecks = [];
  int rowsPerPages = 10;
  bool isShadow = false;
  List<bool> isHovered = [false, false, false, false, false];
  List<Widget> myItems = [];
  Widget next = Container();
  bool isLoading = true;
  late User currentUser;
  late Role selectedRole;
  bool added = false;
  Season? selectedSeason = Season(seasons: "الموسم", id: -1);
  Season? filteredSeason = Season(seasons: "الموسم", id: -1);

  Category? selectedCategory = Category(categorieAge: "العمر", id: -1);
  Grade? selectedGrade = Grade(grade: "Grade", id: -1);
  Ligue? selectedLigue = Ligue(name: "الولاية", id: -1);
  Degree? selectedDegree = Degree(degree: "Degree", id: -1);
  Weight? selectedWeight = Weight(masseEnKillograme: 0, id: -1);
  Discipline? selectedDiscipline = Discipline(name: "الرياضة", id: -1);
  Club? selectedClub = Club(name: "النادي", id: -1);
  Category? filteredCategory = Category(categorieAge: "العمر", id: -1);

  Role? filteredRole = Role(roles: "نوع الاجازة", id: -1);
  Grade? filteredGrade = Grade(grade: "Grade", id: -1);
  Degree? filteredDegree = Degree(degree: "Degree", id: -1);
  Weight? filteredWeight = Weight(masseEnKillograme: 0, id: -1);
  Discipline? filteredDiscipline = Discipline(name: "الرياضة", id: -1);
  Club? filteredClub = Club(name: "النادي", id: -1);
  String filteredSex = "الجنس";
  String filteredStatus = "الحالة";
  String selectedStatus = "الحالة";
  DateTime? selectedBirth;
  String selectedSex = "الجنس";
  String selectedState = "الولاية";
  Apis apis = Apis();
  late SharedPreferences prefs;
  late Stats stats = Stats();
  FullLicence? createdFullLicence = FullLicence(
      profile: Profile(),
      licence: Licence(),
      user: User(),
      arbitrator: Arbitrator(),
      athlete: Athlete(),
      coach: Coach());
  final picker = ImagePickerWindows();
  Parameters? parameters;
  List<FullLicence> exportFullLicences = [];
  List<FullLicence> fullLicences = [];
  List<FullLicence> fullAthleteLicences = [];
  List<FullLicence> fullArbitratorLicences = [];
  List<FullLicence> fullCoachLicences = [];
  List<FullLicence> filteredFullLicences = [];
  late Season activeSeason;
  LicenceNetwork licenceNetwork = LicenceNetwork();
  FullLicence? selectedFullLicence;

  changeRowPerPage() {
    rowsPerPages = 20;
    notify();
  }

  Future<bool> login(context, login, password) async {
    // ////print('ddd');
    try {
      Map<String, dynamic> data = {"username": login, "password": password};
      Response res = await licenceNetwork.login(data);
      //print(res.data);
      if (res.statusCode == 200) {
        if (res.data != null) {
          Apis.tempToken = 'TOKEN ' + res.data['token'];

          currentUser = User.fromJson(res.data);

          currentUser.id = res.data['user_data']['id'];
          currentUser.isSuperuser = res.data['user_data']['is_superuser'];
          prefs = await SharedPreferences.getInstance();
          prefs.setString('user', login);
          prefs.setString('psd', password);
          GoRouter.of(context).go(Routes.Home);
        }
        return true;
      } else {
        final snackBar = MySnackBar(
          title: 'فشل تسجيل الدخول',
          msg: 'رقم الهاتف او كلمة المرور خاطئين',
          state: ContentType.failure,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        return false;
      }
    } catch (e) {
      final snackBar = MySnackBar(
        title: 'فشل تسجيل الدخول',
        msg: 'رقم الهاتف او كلمة المرور خاطئين',
        state: ContentType.failure,
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      return false;
    }
  }

  clearPrefs() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  checkLogin(context) async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user') &&
        prefs.getString('user') != null &&
        prefs.getString('user') != "") {
      bool ok =
          await login(context, prefs.getString('user'), prefs.getString('psd'));
      if (ok == true) {
        next = const HomeScreen();
      } else {
        next = const LoginScreen();
        GoRouter.of(context).go(Routes.Login);
      }
    } else {
      next = const LoginScreen();
      GoRouter.of(context).go(Routes.Login);
      return true;
    }
    // next=LoginScreen();
    //   GoRouter.of(context).go(Routes.Login);
    // return true;
  }

  logout(context) async {
    prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.remove('psd');
    GoRouter.of(context).go(Routes.Login);
  }

  deleteLicence(id, context, season, {role}) async {
    try {
      Response res = await licenceNetwork.deleteLicence(id);
      if (res.statusCode == 204) {
        if (fullLicences.isNotEmpty) {
          fullLicences
              .removeWhere((element) => element.licence!.numLicences == id);
        }

        // if(role==2){
        //   if(fullAthleteLicences.isNotEmpty){
        //     fullAthleteLicences.removeWhere((element) => element.licence!.numLicences==id);
        //   }
        // }
        // else if(role==4){
        //   if(fullCoachLicences.isNotEmpty){
        //     fullCoachLicences.removeWhere((element) => element.licence!.numLicences==id);
        //   }
        // }
        // else if(role==1){
        //   if(fullArbitratorLicences.isNotEmpty){
        //     fullArbitratorLicences.removeWhere((element) => element.licence!.numLicences==id);
        //   }
        // }
        print(role);
        final snackBar = MySnackBar(
          title: 'نجاح الحذف',
          msg: 'تم حذف اجازة الرياضي بنجاح',
          state: ContentType.success,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        // notify();
      } else {
        final snackBar = MySnackBar(
          title: 'فشل الحذف',
          msg: 'لا يمكن حذف اجازة الرياضي',
          state: ContentType.failure,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
      notify();
      // getPaginatedLicences(season,role: role);
    } catch (e) {
      final snackBar = MySnackBar(
        title: 'Erreur',
        msg: 'Il y\'a un erreur pour le moment',
        state: ContentType.failure,
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  searchLicences(context, id, role) async {
    filteredFullLicences.clear();
    dynamic club;
    if (currentUser.club?.id == null) {
      club = (filteredClub!.id != -1) ? filteredClub!.id : "";
    } else {
      club = currentUser.club?.id;
    }
    Response res = await licenceNetwork.searchLicences(id, role, club);
    if ((res.statusCode == 200)) {
      print(res.data);
      for (int i = 0; i < res.data.length; i++) {
        Profile profile = Profile.fromJson(res.data[i]['profile']);
        Athlete athlete = Athlete.fromJson(res.data[i]['data']);
        Licence licence = Licence.fromJson(res.data[i]['licence']);

        FullLicence fullLicence = FullLicence(
          athlete: athlete,
          profile: profile,
          licence: licence,
        );
        filteredFullLicences.add(fullLicence);
      }
      //   fullLicences.clear();
      // fullLicences=filteredFullLicences;

      // FullLicence licence=FullLicence
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SearchedLicencesScreen()));
      // GoRouter.of(context).push(Routes.FilteredLicencesScreen);
      final snackBar = MySnackBar(
        title: 'اجازة موجودة',
        msg: 'تم ايجاد الاجازة المطلوبة بنجاح',
        state: ContentType.success,
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notify();
    } else {
      final snackBar = MySnackBar(
        title: 'اجازة غير موجودة',
        msg: 'الاجازة المطلوبة غير موجودة',
        state: ContentType.failure,
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  filterLicences(context) async {
    fullLicences.clear();
    // if(selectedRole)
    dynamic role = (filteredRole!.id != -1) ? filteredRole!.id : "";
    dynamic state = (filteredStatus != "الحالة") ? filteredStatus : "";
    // dynamic state=(filteredStatus!.id!=-1)?filteredStatus!.id:"";
    dynamic season = (filteredSeason!.id != -1) ? filteredSeason!.id : "";
    // dynamic season=(filteredRole!.id!=-1)?selectedSeason!.id:"";
    dynamic club;
    if (currentUser.club?.id == null) {
      club = (filteredClub!.id != -1) ? filteredClub!.id : "";
    } else {
      club = currentUser.club?.id;
    }
    dynamic categorie =
        (filteredCategory!.id != -1) ? filteredCategory!.id : "";
    dynamic degree = (filteredDegree!.id != -1) ? filteredDegree!.id : "";
    dynamic grade = (filteredGrade!.id != -1) ? filteredGrade!.id : "";
    dynamic weight = (filteredWeight!.id != -1) ? filteredWeight!.id : "";
    dynamic discipline =
        (filteredDiscipline!.id != -1) ? filteredDiscipline!.id : "";
    // print(object)
    Map<String, dynamic> mapdata = {
      "userid": 274,
      "state": state,
      "page_number": currentPage,
      "page_size": 10,
      "role": role,
      "season": season,
      "club": club,
      "user": "",
      "categorie": categorie,
      "degree": degree,
      "grade": grade,
      "weight": weight,
      "discipline": discipline,
    };
    print(mapdata);
    Response res = await licenceNetwork.filterLicences(mapdata, 10, 10);
    if (res.statusCode == 200) {
      filteredFullLicences.clear();
      for (int i = 0; i < res.data.length; i++) {
        // print(res.data[i]['profile']['role']);
        print(res.data);
        Profile profile = Profile.fromJson(res.data[i]['profile']);
        Licence licence = Licence.fromJson(res.data[i]['licence']);
        late FullLicence fullLicence;
        if (profile.role == 2) {
          Athlete athlete = Athlete.fromJson(res.data[i]['data']);
          fullLicence =
              FullLicence(licence: licence, profile: profile, athlete: athlete);
        } else if (profile.role == 1) {
          Arbitrator arbitrator = Arbitrator.fromJson(res.data[i]['data']);
          fullLicence = FullLicence(
              licence: licence, profile: profile, arbitrator: arbitrator);
        } else if (profile.role == 4) {
          Coach coach = Coach.fromJson(res.data[i]['data']);
          fullLicence =
              FullLicence(licence: licence, profile: profile, coach: coach);
        }
        filteredFullLicences.add(fullLicence);
      }
      fullLicences = filteredFullLicences;

      final snackBar = MySnackBar(
        title: 'اجازة موجودة',
        msg: 'تم ايجاد الاجازة المطلوبة بنجاح',
        state: ContentType.success,
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notify();
      print(res.data);
    } else {
      final snackBar = MySnackBar(
        title: 'اجازة غير موجودة',
        msg: 'الاجازة المطلوبة غير موجودة',
        state: ContentType.failure,
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }

    // selectedStatus = "الحالة";
    //  selectedState = "الولاية";
  }

  searchFullLicence(context, id) async {
    Response res = await licenceNetwork.getLicenceById(id);
    if (res.statusCode == 200) {
      // FullLicence licence=FullLicence
      Profile profile = Profile.fromJson(res.data['profile']);
      Athlete athlete = Athlete.fromJson(res.data['athlete']);
      Licence licence = Licence.fromJson(res.data);
      FullLicence fullLicence = FullLicence(
        athlete: athlete,
        profile: profile,
        licence: licence,
      );
      selectedFullLicence = fullLicence;

      final snackBar = MySnackBar(
        title: 'اجازة موجودة',
        msg: 'تم ايجاد الاجازة المطلوبة بنجاح',
        state: ContentType.success,
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notify();
      GoRouter.of(context).push(Routes.LicenceScreen);
    } else {
      final snackBar = MySnackBar(
        title: 'اجازة غير موجودة',
        msg: 'الاجازة المطلوبة غير موجودة',
        state: ContentType.failure,
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  checkVersion(context) async {
    Response res = await licenceNetwork.getLatestVersion();
    Version version = Version.fromJson(res.data);
    //print('got version');
    if (version.version == currentVersion.version) {
      //print('good');
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                title: const Text("تحديث جديد"),
                content: SizedBox(
                    height: 10.h,
                    child: const Center(
                        child: Text(
                            "يوجد تحديث جديد من البرنامج الرجاء التحديث"))),
                actions: [
                  ElevatedButton(
                      onPressed: () async {
                        final Uri url = Uri.parse(version.url!);
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: const Text("تحديث")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("الغاء"))
                ],
              ),
            );
          });
      //print('please update');
    }
  }

  showImage(context, img) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Image.network(img),
          );
        });
  }

  // sortColumn(index){

  //   currentSortColumn = index;
  //   if (isAscending == true) {
  //     isAscending = false;
  //     // sort the product list in Ascending, order by Price
  //     fullLicences.sort((licenceA, licenceB) =>
  //         licenceB.licence!.numLicences!.compareTo(licenceA.licence!.numLicences!));
  //         notify();
  //   } else {
  //     isAscending = true;
  //     // sort the product list in Descending, order by Price
  //     fullLicences.sort((licenceA, licenceB) =>
  //         licenceA.licence!.numLicences!.compareTo(licenceB.licence!.numLicences!));
  //         notify();
  //   }
  //   // notify();

  // }

  validateLicence(context) async {
    Response res = await licenceNetwork
        .validateLicence(selectedFullLicence!.licence!.numLicences);
    if (res.statusCode == 200) {
      if (res.data != null) {
        selectedFullLicence!.licence!.activated = true;
        selectedFullLicence!.licence!.state = "نشطة";
        notify();
        final snackBar = MySnackBar(
          title: 'نجاح الاضافة',
          msg: 'تم نجاح تفعيل اجازة الرياضي',
          state: ContentType.success,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        final snackBar = MySnackBar(
          title: 'فشل التفعيل',
          msg: 'تم فشل تفعيل هذه الاجازة',
          state: ContentType.failure,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    }
  }

  getPaginatedLicences(season, {int? role}) async {
    // if (fullLicences.isNotEmpty) {
    fullLicences.clear();
    // }
    // lice
    fullArbitratorLicences.clear();
    fullAthleteLicences.clear();
    fullCoachLicences.clear();
    Response res = await licenceNetwork.getPaginatedLicenceListInfo(
        currentUser.club!.id ?? "", 10, currentPage, season,
        role: role);
    if (res.statusCode == 200) {
      if (res.data != null) {
        for (var r in res.data) {
          if (r['profile'] != null) {
            FullLicence fullLicence = FullLicence();

            Profile profile = Profile.fromJson(r['profile']);
            fullLicence.profile = profile;
            Licence licence = Licence.fromJson(r['licence']);
            fullLicence.licence = licence;
            if (licence.role == "رياضي") {
              Athlete athlete = Athlete.fromJson(r['data']);
              fullLicence.athlete = athlete;
              fullAthleteLicences.add(fullLicence);
            } else if (licence.role == "حكم") {
              Arbitrator arbitrator = Arbitrator.fromJson(r['data']);
              fullLicence.arbitrator = arbitrator;
              fullArbitratorLicences.add(fullLicence);
            } else if (licence.role == "مدرب") {
              Coach coach = Coach.fromJson(r['data']);
              fullLicence.coach = coach;
              fullCoachLicences.add(fullLicence);
            }
            fullLicences.add(fullLicence);
            // notify();
          }
        }
        // notify();
      }
    }
    isLoading = false;
    // notify();
  }

  getLicences(data) async {
    isLoading=true;
    notify();
    if (fullLicences.isNotEmpty) {
      exportFullLicences.clear();
    }
    // fullArbitratorLicences.clear();
    // fullAthleteLicences.clear();
    // fullCoachLicences.clear();
    Response res = await licenceNetwork.getLicenceListInfo(data);
    if (res.statusCode == 200) {
      if (res.data != null) {
        for (var r in res.data) {
          if (r['profile'] != null) {
            FullLicence fullLicence = FullLicence();

            Profile profile = Profile.fromJson(r['profile']);
            fullLicence.profile = profile;
            Licence licence = Licence.fromJson(r['licence']);
            fullLicence.licence = licence;
            if (licence.role == "رياضي") {
              Athlete athlete = Athlete.fromJson(r['data']);
              fullLicence.athlete = athlete;
              fullAthleteLicences.add(fullLicence);
            } else if (licence.role == "حكم") {
              Arbitrator arbitrator = Arbitrator.fromJson(r['data']);
              fullLicence.arbitrator = arbitrator;
              fullArbitratorLicences.add(fullLicence);
            } else if (licence.role == "مدرب") {
              Coach coach = Coach.fromJson(r['data']);
              fullLicence.coach = coach;
              fullCoachLicences.add(fullLicence);
            }
            exportFullLicences.add(fullLicence);
            notify();
          }
        }
        notify();
      }
    }
    isLoading = false;
    print(exportFullLicences);
    notify();
  }

  initCreate() {
    initSelected();
    createdFullLicence = FullLicence(
        profile: Profile(),
        licence: Licence(),
        user: User(),
        arbitrator: Arbitrator(),
        athlete: Athlete(),
        coach: Coach());
    selectedFullLicence = FullLicence(
        profile: Profile(),
        licence: Licence(),
        user: User(),
        arbitrator: Arbitrator(),
        athlete: Athlete(),
        coach: Coach());
  }

  initSelected() {
    selectedFullLicence = FullLicence();
    selectedSeason = Season(seasons: "الموسم", id: -1);
    selectedCategory = Category(categorieAge: "العمر", id: -1);
    selectedGrade = Grade(grade: "Grade", id: -1);
    selectedDegree = Degree(degree: "Degree", id: -1);
    selectedWeight = Weight(masseEnKillograme: 0, id: -1);
    selectedDiscipline = Discipline(name: "الرياضة", id: -1);
    selectedClub = Club(name: "النادي", id: -1);
    selectedState = "الولاية";
    selectedSex = 'الجنس';
  }

  getParameters() async {
    Response res = await licenceNetwork.getParameters();
    if (res.statusCode == 200) {
      if (res.data != null) {
        parameters = Parameters();
        List<Club> clubs = [];
        for (var l in res.data['Clubs']) {
          Club club = Club.fromJson(l);
          clubs.add(club);
          if(club.hasCoach==false)
          NonDefaultClubs.add(club);
          notify();
        }
        parameters!.clubs = clubs;
        notify();
        List<Ligue> ligues = [];
        for (var l in res.data['Ligues']) {
          Ligue ligue = Ligue.fromJson(l);
          ligues.add(ligue);
        }
        parameters!.ligues = ligues;
        List<Grade> grades = [];
        for (var l in res.data['Grades']) {
          Grade grade = Grade.fromJson(l);
          grades.add(grade);
        }
        parameters!.grades = grades;

        List<Degree> degrees = [];
        for (var l in res.data['Degrees']) {
          Degree degree = Degree.fromJson(l);
          degrees.add(degree);
        }
        parameters!.degrees = degrees;

        List<Role> roles = [];
        for (var l in res.data['Roles']) {
          Role role = Role.fromJson(l);
          roles.add(role);
        }
        parameters!.roles = roles;
        List<Weight> weights = [];
        for (var l in res.data['Weights']) {
          Weight weight = Weight.fromJson(l);
          weights.add(weight);
        }
        parameters!.weights = weights;
        List<Category> categories = [];
        for (var l in res.data['Categories']) {
          Category category = Category.fromJson(l);
          categories.add(category);
        }
        parameters!.categories = categories;
        List<Discipline> disciplines = [];
        for (var l in res.data['Disciplines']) {
          Discipline discipline = Discipline.fromJson(l);
          disciplines.add(discipline);
        }
        parameters!.disciplines = disciplines;
        List<Season> seasons = [];
        for (var l in res.data['Seasons']) {
          Season season = Season.fromJson(l);
          seasons.add(season);
          // if(seasons[l].activated==true){
          //   activeSeason=seasons[l];
          // }
        }
        parameters!.seasons = seasons;
        notify();
      }
    }
  }

  notify() {
    notifyListeners();
  }

  getCoachImagePath(String? toFillImage) {
    if (toFillImage == 'profilePhoto') {
      return "image/profile/";
    } else if (toFillImage == 'idphoto') {
      return "image/coach/identity";
    } else if (toFillImage == "photo") {
      return "image/coach/photo";
    } else if (toFillImage == "degreephoto") {
      return "image/coach/degree";
    } else if (toFillImage == "gradephoto") {
      return "image/coach/grade";
    }
  }

  setCoachImagePath(String? toFillImage, String url) {
    if (toFillImage == "profilePhoto") {
      createdFullLicence!.profile!.profilePhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
    } else if (toFillImage == 'idphoto') {
      createdFullLicence!.coach!.identityPhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
    } else if (toFillImage == "photo") {
      createdFullLicence!.coach!.photo =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
    } else if (toFillImage == "gradephoto") {
      createdFullLicence!.coach!.gradePhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
    } else if (toFillImage == "degreephoto") {
      createdFullLicence!.coach!.degreePhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
    }
  }

  setArbitreImagePath(String? toFillImage, String url) {
    if (toFillImage == "profilePhoto") {
      createdFullLicence!.profile!.profilePhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
    } else if (toFillImage == 'idphoto') {
      createdFullLicence!.arbitrator!.identityPhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
    } else if (toFillImage == "photo") {
      createdFullLicence!.arbitrator!.photo =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
    }
  }

  getArbitreImagePath(String? toFillImage) {
    if (toFillImage == 'profilePhoto') {
      return "image/profile/";
    } else if (toFillImage == 'idphoto') {
      return "image/arbitrator/identity";
    } else if (toFillImage == "photo") {
      return "image/arbitrator/photo";
    }
  }

  getAthleteImagePath(String? toFillImage) {
    if (toFillImage == 'profilePhoto') {
      return "image/profile/";
    } else if (toFillImage == 'idphoto') {
      return "image/athlete/identity";
    } else if (toFillImage == "photo") {
      return "image/athlete/photo";
    } else if (toFillImage == "medphoto") {
      return "image/athlete/medical";
    }
  }

  setAthleteImagePath(String? toFillImage, String url) {
    if (toFillImage == "profilePhoto") {
      createdFullLicence!.profile!.profilePhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
    } else if (toFillImage == 'idphoto') {
      createdFullLicence!.athlete!.identityPhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
    } else if (toFillImage == "photo") {
      createdFullLicence!.athlete!.photo =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
    } else if (toFillImage == "medphoto") {
      createdFullLicence!.athlete!.medicalPhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
    }
  }

  pickEditImage(bool fromGallery, context, String? toFillImage) async {
    final picker = ImagePickerWindows();
    PickedFile? file = await picker.pickImage(source: ImageSource.gallery);
    String path = getAthleteImagePath(toFillImage);
    uploadEditImage(file, path, 6, toFillImage);
    Navigator.pop(context);
  }

  pickAthleteImage(bool fromGallery, context, String? toFillImage) async {
    final picker = ImagePickerWindows();
    PickedFile? file = await picker.pickImage(source: ImageSource.gallery);
    String path = getAthleteImagePath(toFillImage);
    uploadAthleteImage(file!, path, 6, toFillImage);
  }

  pickArbitreImage(bool fromGallery, context, String? toFillImage) async {
    final picker = ImagePickerWindows();
    PickedFile? file = await picker.pickImage(source: ImageSource.gallery);
    String path = getArbitreImagePath(toFillImage);
    uploadArbitreImage(file!, path, 6, toFillImage, context);
  }

  pickCoachImage(bool fromGallery, context, String? toFillImage) async {
    final picker = ImagePickerWindows();
    PickedFile? file = await picker.pickImage(source: ImageSource.gallery);
    String path = getCoachImagePath(toFillImage);
    await uploadCoachImage(file!, path, 6, toFillImage);
  }

  uploadAthleteImage(
      PickedFile image, path, season, String? toFillImage) async {
    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "url": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
      "path": path,
      "season": season,
      "user": 274
    });

    Response res = await licenceNetwork.uploadImage(formData);
    if (res.statusCode == 200) {
      if (res.data != null) {
        setAthleteImagePath(toFillImage, res.data['url']);
        notify();
      }
    }
  }

  uploadArbitreImage(
      PickedFile image, path, season, String? toFillImage, context) async {
    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "url": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
      "path": path,
      "season": season,
      "user": 274
    });
    Response res = await licenceNetwork.uploadImage(formData);
    if (res.statusCode == 200) {
      if (res.data != null) {
        setArbitreImagePath(toFillImage, res.data['url']);
        notify();
      }
    }
  }

  uploadCoachImage(PickedFile image, path, season, String? toFillImage) async {
    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "url": await MultipartFile.fromFile(image.path, filename: fileName),
      "path": path,
      "season": season,
      "user": 274
    });
    // print(formData.fields);
    // print(formData.files);
    Response res = await licenceNetwork.uploadImage(formData);
    // print("upload coach status: "+res.statusCode.toString());
    if (res.statusCode == 200) {
      if (res.data != null) {
        setCoachImagePath(toFillImage, res.data['url']);
        notify();
      }
    } else {
      // print(res.data);
    }
  }

  uploadEditImage(PickedFile? image, path, season, String? toFillImage) async {
    String fileName = image!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "url": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
      ),
      "path": path,
      "season": season,
      "user": 274
    });
    Response res = await licenceNetwork.uploadImage(formData);
    if (res.statusCode == 200) {
      if (res.data != null) {
        setAthleteImagePath(toFillImage, res.data['url']);
        notify();
      }
    }
  }

  createAthleteProfile(
      {String? address,
      String? cin,
      String? firstName,
      String? lastName,
      String? phone,
      String? state}) {
    createdFullLicence!.profile!.address = address;
    createdFullLicence!.profile!.birthday = selectedBirth!.year.toString() +
        "-" +
        selectedBirth!.month.toString() +
        "-" +
        selectedBirth!.day.toString();
    // selectedBirth.toString();
    createdFullLicence!.profile!.cin = cin;
    // createdFullLicence.profile.profilePhoto=sele
    createdFullLicence!.profile!.country = 'تونس';
    createdFullLicence!.profile!.firstName = firstName;
    createdFullLicence!.profile!.lastName = lastName;
    createdFullLicence!.profile!.phone = int.parse(phone!);
    createdFullLicence!.profile!.role = 2;
    createdFullLicence!.profile!.sexe = selectedSex;
    DateTime today = DateTime.now();

    // DateTime birthday=DateTime();

    Duration age = today.difference(selectedBirth!);
    // print(age.inDays/365);
    double years = age.inDays / 365;
    if (7 >= years && years >= 6) {
      autoCategory =
          parameters!.categories!.firstWhere((element) => element.id == 11);
    } else if (9 >= years && years >= 8) {
      autoCategory =
          parameters!.categories!.firstWhere((element) => element.id == 10);
    } else if (11 >= years && years >= 10) {
      autoCategory =
          parameters!.categories!.firstWhere((element) => element.id == 6);
    } else if (13 >= years && years >= 12) {
      autoCategory =
          parameters!.categories!.firstWhere((element) => element.id == 5);
    } else if (15 >= years && years >= 14) {
      autoCategory =
          parameters!.categories!.firstWhere((element) => element.id == 4);
    } else if (17 >= years && years >= 16) {
      autoCategory =
          parameters!.categories!.firstWhere((element) => element.id == 3);
    } else if (40 >= years && years >= 18) {
      autoCategory =
          parameters!.categories!.firstWhere((element) => element.id == 2);
    } else {
      autoCategory =
          parameters!.categories!.firstWhere((element) => element.id == 1);
    }
    // createdFullLicence!.profile!.state = selectedState;
    User user = User(
        isSuperuser: false,
        username: createdFullLicence!.profile!.phone.toString(),
        password: "12345");
    createdFullLicence!.user = user;
  }

  createCoachProfile(
      {String? address,
      String? cin,
      String? firstName,
      String? lastName,
      String? phone,
      String? state}) {
    createdFullLicence!.profile!.address = address;
    createdFullLicence!.profile!.birthday = selectedBirth!.year.toString() +
        "-" +
        selectedBirth!.month.toString() +
        "-" +
        selectedBirth!.day.toString();
    createdFullLicence!.profile!.cin = cin;
    createdFullLicence!.profile!.firstName = firstName;
    createdFullLicence!.profile!.lastName = lastName;
    createdFullLicence!.profile!.phone = int.parse(phone!);
    createdFullLicence!.profile!.role = 4;
    createdFullLicence!.profile!.sexe = selectedSex;
    createdFullLicence!.profile!.state = selectedState;
    User user = User(
        isSuperuser: false,
        username: createdFullLicence!.profile!.phone.toString(),
        password: "12345");
    createdFullLicence!.user = user;
  }

  createArbitreProfile(
      {String? address,
      String? cin,
      String? firstName,
      String? lastName,
      String? phone,
      String? state}) {
    createdFullLicence!.profile!.address = address;
    createdFullLicence!.profile!.birthday = selectedBirth!.year.toString() +
        "-" +
        selectedBirth!.month.toString() +
        "-" +
        selectedBirth!.day.toString();
    createdFullLicence!.profile!.cin = cin;
    createdFullLicence!.profile!.firstName = firstName;
    createdFullLicence!.profile!.lastName = lastName;
    createdFullLicence!.profile!.phone = int.parse(phone!);
    createdFullLicence!.profile!.role = 1;
    createdFullLicence!.profile!.sexe = selectedSex;
    createdFullLicence!.profile!.state = selectedState;
    User user = User(
        isSuperuser: false,
        username: createdFullLicence!.profile!.phone.toString(),
        password: "12345");
    createdFullLicence!.user = user;
  }

  createArbitre(context) {
    createdFullLicence!.arbitrator!.grade = selectedGrade!.id;
    if (currentUser.club!.id == null) {
      createdFullLicence!.arbitrator!.club = null;
    } else {
      createdFullLicence!.arbitrator!.club = currentUser.club!.id;
    }
    createArbitreLicence(context);
  }

  createArbitreLicence(context) async {
    added = true;
    createdFullLicence!.licence!.grade = selectedGrade!.id;
    if (currentUser.club!.id == null) {
      createdFullLicence!.licence!.club = null;
    } else {
      createdFullLicence!.licence!.club = currentUser.club!.id;
    }
    createdFullLicence!.licence!.activated = false;
    createdFullLicence!.licence!.state = "في الانتظار";
    createdFullLicence!.licence!.verified = false;
    createdFullLicence!.licence!.role = 1;
    Map<String, dynamic> mapdata = {};
    mapdata['licence'] = createdFullLicence!.licence!.toJson();
    mapdata['user'] = createdFullLicence!.user!.toJson();
    mapdata['arbitre'] = createdFullLicence!.arbitrator!.toJson();
    mapdata['profile'] = createdFullLicence!.profile!.toJson();
    print(mapdata['licence']);
    // log(
    //   mapdata.toString(),
    //   name: mapdata.toString(),
    //   error: mapdata,
    // );
    try {
      Response res = await licenceNetwork.addFullLicence(mapdata);
      if (res.statusCode == 200) {
        print('aaa');
        createdFullLicence!.licence!.role = 'حكم';
        print('bbb');
        createdFullLicence!.licence!.numLicences =
            res.data['licence']['num_licences'];
        print('ccc');
        createdFullLicence!.profile!.id = res.data['profile']['id'];
        print('ddd');
        createdFullLicence!.user!.id = res.data['user']['id'];
        print('eee');
        print(res.data);
        createdFullLicence!.arbitrator!.id = res.data['arbitre']['id'];
        print('fff');
        createdFullLicence!.licence!.seasons = activeSeason.seasons;
        // fullLicences.add(createdFullLicence!);
        print('eee');
        fullLicences.insert(0, createdFullLicence!);
        notifyListeners();
        ////print('ok');
        // Navigator.pop(context);
        // Navigator.pop(context);
        // Navigator.pop(context);
        final snackBar = MySnackBar(
          title: 'Succees',
          msg: 'La licence de ce athlete a ete ajoute avec succees',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          state: ContentType.success,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        ////print('not ok');
        ////print(res.statusMessage);
        final snackBar = MySnackBar(
          title: 'فشل الاضافة',
          msg: 'تم فشل اضافة اجازة الحكم',
          state: ContentType.warning,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = MySnackBar(
        title: 'Probleme',
        msg:
            'Il y a une probleme dans cet instant merci d\'essayer ulterieurement',
        state: ContentType.failure,
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  // RefuseLicence(){

  // }

  createAthlete(context) {
    createdFullLicence!.athlete!.categoryId = autoCategory.id;
    // if(createdFullLicence.profile.birthday)
    // createdFullLicence!.athlete!.gradeId = selectedGrade!.id;
    if (currentUser.club!.id == null) {
      createdFullLicence!.athlete!.club = selectedClub!.id;
    } else {
      createdFullLicence!.athlete!.club = currentUser.club!.id;
    }
    createdFullLicence!.athlete!.discipline = selectedDiscipline!.id;
    createdFullLicence!.athlete!.weights = selectedWeight!.id;
    // createdFullLicence!.athlete!.idDegree = selectedDegree!.id;

    // print('aaaaaaaaaa');
    createAthleteLicence(context);
  }

  createCoach(context) {
    // createdFullLicence!.coach!.categoryId = selectedCategory!.id;
    // createdFullLicence!.coach!.grade = selectedGrade!.id;
    if (currentUser.club!.id == null) {
      createdFullLicence!.coach!.club = selectedClub!.id;
    } else {
      createdFullLicence!.coach!.club = currentUser.club!.id;
    }
    createdFullLicence!.coach!.discipline = selectedDiscipline!.id;
    // createdFullLicence!.coach!.weights = selectedWeight!.id;
    // createdFullLicence!.coach!.degree = selectedDegree!.id;
    createCoachLicence(context);
  }

  createCoachLicence(context) async {
    added = true;
    // createdFullLicence!.licence!.categorie = selectedCategory!.id;
    createdFullLicence!.licence!.grade = selectedGrade!.id;
    if (currentUser.club!.id == null) {
      createdFullLicence!.licence!.club = selectedClub!.id;
    } else {
      createdFullLicence!.licence!.club = currentUser.club!.id;
    }
    createdFullLicence!.licence!.discipline = selectedDiscipline!.id;
    // createdFullLicence!.licence!.weight = selectedWeight!.id;
    createdFullLicence!.licence!.degree = selectedDegree!.id;
    createdFullLicence!.licence!.activated = false;
    createdFullLicence!.licence!.state = selectedState;
    createdFullLicence!.licence!.verified = false;
    createdFullLicence!.licence!.role = 4;
    Map<String, dynamic> mapdata = {};
    mapdata['licence'] = createdFullLicence!.licence!.toJson();
    mapdata['user'] = createdFullLicence!.user!.toJson();
    mapdata['coach'] = createdFullLicence!.coach!.toJson();
    mapdata['profile'] = createdFullLicence!.profile!.toJson();
    log(
      mapdata.toString(),
      name: mapdata.toString(),
      error: mapdata,
    );
    try {
      Response res = await licenceNetwork.addFullLicence(mapdata);
      if (res.statusCode == 200) {
        createdFullLicence!.licence!.role = "مدرب";
        // createdFullLicence!.licence!.categorie = selectedCategory!.categorieAge;
        createdFullLicence!.licence!.grade = selectedGrade!.grade;
        if (currentUser.club!.id == null) {
          createdFullLicence!.licence!.club = selectedClub!.name;
        } else {
          createdFullLicence!.licence!.club = currentUser.club!.name;
        }
        createdFullLicence!.licence!.state = res.data['licence']['state'];
        createdFullLicence!.licence!.discipline = selectedDiscipline!.name;
        // createdFullLicence!.licence!.weight = selectedWeight!.masseEnKillograme;
        createdFullLicence!.licence!.degree = selectedDegree!.degree;
        // createdFullLicence!.athlete!.categoryId = selectedCategory!.categorieAge;
        // createdFullLicence!.athlete!.gradeId = selectedGrade!.grade;
        if (currentUser.club!.id == null) {
          createdFullLicence!.coach!.club = selectedClub!.name;
        } else {
          createdFullLicence!.coach!.club = currentUser.club!.name;
        }
        createdFullLicence!.coach!.discipline = selectedDiscipline!.name;
        // createdFullLicence!.athlete!.weights = selectedWeight!.masseEnKillograme;
        // createdFullLicence!.coach!.idDegree = selectedDegree!.degree;
        createdFullLicence!.licence!.seasons = activeSeason.seasons;
        createdFullLicence!.licence!.numLicences =
            res.data['licence']['num_licences'];
        createdFullLicence!.profile!.id = res.data['profile']['id'];
        createdFullLicence!.coach!.id = res.data['coach']['id'];
        fullLicences.insert(0, createdFullLicence!);
        fullCoachLicences.insert(0, createdFullLicence!);
        notify();
        ////print('ok');
        // Navigator.pop(context);
        // Navigator.pop(context);
        // Navigator.pop(context);
        // final snackBar = MySnackBar(
        //   title: 'Succees',
        //   msg: 'La licence de ce athlete a ete ajoute avec succees',

        //   /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        //   state: ContentType.success,
        // );
        // ScaffoldMessenger.of(context)
        //   ..hideCurrentSnackBar()
        //   ..showSnackBar(snackBar);
      } else {
        final snackBar = MySnackBar(
          title: 'فشل الاضافة',
          msg: 'تم فشل اضافة اجازة المدرب',
          state: ContentType.warning,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = MySnackBar(
        title: 'Probleme',
        msg:
            'Il y a une probleme dans cet instant merci d\'essayer ulterieurement',
        state: ContentType.failure,
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  createAthleteLicence(context) async {
    if (selectedWeight!.id == -1) {
      // selectedWeight=null;
      createdFullLicence!.licence!.weight = null;
      createdFullLicence!.athlete!.weights = null;
    }
    added = true;
    createdFullLicence!.licence!.categorie = autoCategory.id;
    // createdFullLicence!.licence!.grade = selectedGrade!.id;
    if (currentUser.club!.id == null) {
      createdFullLicence!.licence!.club = selectedClub!.id;
    } else {
      createdFullLicence!.licence!.club = currentUser.club!.id;
    }
    createdFullLicence!.licence!.discipline = selectedDiscipline!.id;
    // createdFullLicence!.licence!.weight = selectedWeight!.id;
    // createdFullLicence!.licence!.degree = selectedDegree!.id;
    createdFullLicence!.licence!.activated = false;
    createdFullLicence!.licence!.state = selectedState;
    createdFullLicence!.licence!.verified = false;
    createdFullLicence!.licence!.role = 2;
    Map<String, dynamic> mapdata = {};
    mapdata['licence'] = createdFullLicence!.licence!.toJson();
    mapdata['user'] = createdFullLicence!.user!.toJson();
    mapdata['athlete'] = createdFullLicence!.athlete!.toJson();
    mapdata['profile'] = createdFullLicence!.profile!.toJson();
    // mapdata['profile']['licences']=[];
    try {
      Response res = await licenceNetwork.addFullLicence(mapdata);
      if (res.statusCode == 200) {
        createdFullLicence!.licence!.role = "رياضي";
        createdFullLicence!.licence!.categorie = autoCategory.categorieAge;
        createdFullLicence!.licence!.grade = selectedGrade!.grade;
        if (currentUser.club!.id == null) {
          createdFullLicence!.licence!.club = selectedClub!.name;
        } else {
          createdFullLicence!.licence!.club = currentUser.club!.name;
        }
        createdFullLicence!.licence!.state = res.data['licence']['state'];
        createdFullLicence!.licence!.discipline = selectedDiscipline!.name;
        createdFullLicence!.licence!.weight = selectedWeight!.masseEnKillograme;
        createdFullLicence!.licence!.degree = selectedDegree!.degree;
        createdFullLicence!.athlete!.categoryId =
            selectedCategory!.categorieAge;
        createdFullLicence!.athlete!.gradeId = selectedGrade!.grade;
        if (currentUser.club!.id == null) {
          createdFullLicence!.athlete!.club = selectedClub!.name;
        } else {
          createdFullLicence!.athlete!.club = currentUser.club!.name;
        }
        createdFullLicence!.athlete!.discipline = selectedDiscipline!.name;
        createdFullLicence!.athlete!.weights =
            selectedWeight!.masseEnKillograme;
        createdFullLicence!.athlete!.idDegree = selectedDegree!.degree;
        createdFullLicence!.licence!.numLicences =
            res.data['licence']['num_licences'];
        createdFullLicence!.licence!.seasons = activeSeason.seasons;
        createdFullLicence!.profile!.id = res.data['profile']['id'];
        createdFullLicence!.athlete!.id = res.data['athlete']['id'];

        fullLicences.insert(0, createdFullLicence!);
        notify();
      } else {
        final snackBar = MySnackBar(
          title: 'فشل اضافة',
          msg: 'تم فشل اضافة اجازة الرياضي',
          state: ContentType.warning,
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
      notify();
    } catch (e) {
      final snackBar = MySnackBar(
        title: 'Probleme',
        msg:
            'Il y a une probleme dans cet instant merci d\'essayer ulterieurement',
        state: ContentType.failure,
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  showSearchDialog(context, numControl) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SearchDialog(this, numControl, context);
        });
  }

  showFilterDialog(context) {
    selectedSeason = Season(seasons: "الموسم", id: -1);
    selectedCategory = Category(categorieAge: "العمر", id: -1);
    (currentUser.club!.id != null)
        ? selectedClub = currentUser.club
        : selectedClub = Club(name: "النادي", id: -1);
    selectedDegree = Degree(degree: "Degree", id: -1);
    selectedDiscipline = Discipline(name: "الرياضة", id: -1);
    selectedGrade = Grade(grade: "Grade", id: -1);
    selectedWeight = Weight(masseEnKillograme: 0, id: -1);
    selectedSex = "الجنس";
    selectedStatus = "الحالة";

    // filteredCategory = Category(categorieAge: "العمر", id: -1);
    // (currentUser.club!.id!=null)?filteredClub =currentUser.club:filteredClub = Club(name: "النادي", id: -1);
    // filteredDegree = Degree(degree: "Degree", id: -1);
    // filteredDiscipline = Discipline(name: "الرياضة", id: -1);
    // filteredGrade = Grade(grade: "Grade", id: -1);
    // filteredWeight = Weight(masseEnKillograme: 0, id: -1);
    // filteredSex = "الجنس";
    // filteredStatus = "الحالة";
    // filteredRole=Role(roles: "نوع الرياضة",id:-1);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FilterDialog(this, context);
        });
  }

  findLicence(String numLicence, context) {
    filteredFullLicences.clear();
    bool ok = false;
    for (FullLicence licence in fullLicences) {
      if (licence.licence!.numLicences == numLicence) {
        selectedFullLicence = licence;
        ok = true;
        GoRouter.of(context).push(Routes.LicenceScreen);
        break;
      } else if (licence.licence!.numLicences!.contains(numLicence)) {
        ok = true;
        filteredFullLicences.add(licence);
      }
    }

    if (!ok) {
      final snackBar = MySnackBar(
          title: 'Licence Introuvable',
          msg:
              'Le numero de licence que vous avez chercher est inntrouvable merci de le verifier',
          state: ContentType.failure);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      GoRouter.of(context).push(Routes.FilteredLicencesScreen);
    }
    numLicence = '';
  }

  SearchLicence(String keyword, context) async {
    if (keyword.length == 11) {
      Response res = await licenceNetwork.getLicenceById(keyword);
      if (res.statusCode == 200) {
        GoRouter.of(context).push(Routes.LicenceScreen);
      }
      // return res;
    }
  }

// bool findit(){
//   bool ok =false;

//   if(ok)
//   return ok;
//   else
//   return false;

// }

  initArbitreFields() {
    for (Grade grade in parameters!.grades!) {
      if (selectedFullLicence!.licence!.grade == grade.grade) {
        selectedGrade = grade;
        break;
      }
    }
    for (Club club in parameters!.clubs!) {
      if (selectedFullLicence!.licence!.club == club.name) {
        selectedClub = club;
        break;
      }
    }
    selectedState = selectedFullLicence!.profile!.state.toString();
    List<String> date = selectedFullLicence!.profile!.birthday!.split('-');
    selectedBirth = DateTime(
      int.parse(date[0]),
      int.parse(date[1]),
      int.parse(date[2]),
    );
    selectedSex = selectedFullLicence!.profile!.sexe!;
  }

  initFields() {
    for (Category cat in parameters!.categories!) {
      if (selectedFullLicence!.licence!.categorie == cat.categorieAge) {
        selectedCategory = cat;
        break;
      }
    }
    for (Grade grade in parameters!.grades!) {
      if (selectedFullLicence!.licence!.grade == grade.grade) {
        selectedGrade = grade;
        break;
      }
    }
    for (Weight weight in parameters!.weights!) {
      if (selectedFullLicence!.licence!.weight == weight.masseEnKillograme) {
        selectedWeight = weight;
        break;
      }
    }
    for (Degree deg in parameters!.degrees!) {
      if (selectedFullLicence!.licence!.degree == deg.degree) {
        selectedDegree = deg;
        break;
      }
    }
    for (Club club in parameters!.clubs!) {
      if (selectedFullLicence!.licence!.club == club.name) {
        selectedClub = club;
        break;
      }
    }
    for (Discipline disc in parameters!.disciplines!) {
      if (selectedFullLicence!.licence!.discipline == disc.name) {
        selectedDiscipline = disc;
        break;
      }
    }
    selectedState = selectedFullLicence!.profile!.state.toString();
    List<String> date = selectedFullLicence!.profile!.birthday!.split('-');
    selectedBirth = DateTime(
      int.parse(date[0]),
      int.parse(date[1]),
      int.parse(date[2]),
    );
    selectedSex = selectedFullLicence!.profile!.sexe!;
  }

  editProfile(context, {address, firstName, lastName, cin, phone}) async {
    selectedFullLicence!.profile!.address = address;
    selectedFullLicence!.profile!.sexe = selectedSex;
    selectedFullLicence!.profile!.state = selectedState;
    selectedFullLicence!.profile!.firstName = firstName;
    selectedFullLicence!.profile!.lastName = lastName;
    selectedFullLicence!.profile!.cin = cin;
    // selectedFullLicence!.profile!.birthday=selectedBirth;
    selectedFullLicence!.profile!.phone = int.parse(phone);
    selectedFullLicence!.profile!.birthday = selectedBirth!.year.toString() +
        "-" +
        selectedBirth!.month.toString() +
        "-" +
        selectedBirth!.day.toString();
    Map<String, dynamic> mapData = selectedFullLicence!.profile!.toJson();
    // mapData['birthday']=selectedBirth!.year.toString()+"-"+selectedBirth!.month.toString()+"-"+selectedBirth!.day.toString();
    Response res = await licenceNetwork.editProfile(
        mapData, selectedFullLicence!.profile!.id);
    if (res.statusCode == 200) {
      final snackBar = MySnackBar(
          title: "Modification Succees",
          msg: "Le profile de ce athlete a ete modifie avec succees",
          state: ContentType.success);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notifyListeners();
    } else {
      final snackBar = MySnackBar(
          title: "Modification Echec",
          msg: "Echec de modification de profile merci de verifier vos donnee",
          state: ContentType.success);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  editLicenceAthlete(
    context,
  ) async {
    late Season s;
    for (Season season in parameters!.seasons!) {
      if (season.seasons == selectedFullLicence!.licence!.seasons) {
        s = season;
        selectedFullLicence!.licence!.seasons = season.id;
      }
    }
    selectedFullLicence!.licence!.categorie = selectedCategory!.id;
    selectedFullLicence!.licence!.role = 2;
    selectedFullLicence!.licence!.grade = selectedGrade!.id;
    selectedFullLicence!.licence!.weight = selectedWeight!.id;
    selectedFullLicence!.licence!.degree = selectedDegree!.id;
    selectedFullLicence!.licence!.discipline = selectedDiscipline!.id;
    if (currentUser.club!.id == null) {
      selectedFullLicence!.licence!.club = selectedClub!.id;
      selectedFullLicence!.athlete!.club = selectedClub!.id;
    } else {
      selectedFullLicence!.licence!.club = currentUser.club!.id;
      selectedFullLicence!.athlete!.club = currentUser.club!.id;
    }
    selectedFullLicence!.athlete!.categoryId = selectedCategory!.id;
    selectedFullLicence!.athlete!.gradeId = selectedGrade!.id;
    selectedFullLicence!.athlete!.weights = selectedWeight!.id;
    selectedFullLicence!.athlete!.idDegree = selectedDegree!.id;
    selectedFullLicence!.athlete!.discipline = selectedDiscipline!.id;
    Map<String, dynamic> licenceData = selectedFullLicence!.licence!.toJson();
    selectedFullLicence!.licence!.categorie = selectedCategory!.categorieAge;
    selectedFullLicence!.licence!.grade = selectedGrade!.grade;
    selectedFullLicence!.licence!.weight = selectedWeight!.masseEnKillograme;
    selectedFullLicence!.licence!.degree = selectedDegree!.degree;
    selectedFullLicence!.licence!.discipline = selectedDiscipline!.name;
    selectedFullLicence!.licence!.club = selectedClub!.name;
    selectedFullLicence!.licence!.role = "رياضي";
    selectedFullLicence!.licence!.seasons = s.seasons;
    Map<String, dynamic> athleteData = selectedFullLicence!.athlete!.toJson();
    Map<String, dynamic> mapData = {
      'licence': licenceData,
      'athlete': athleteData
    };
    Response res = await licenceNetwork.editAthleteLicence(mapData);
    if (res.statusCode == 200) {
      final snackBar = MySnackBar(
          title: "Modification Succees",
          msg: "La licence de ce athlete a ete modifie avec succees",
          state: ContentType.success);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notifyListeners();
    } else {
      final snackBar = MySnackBar(
          title: "Modification Echec",
          msg: "Echec de modification de licence merci de verifier vos donnee",
          state: ContentType.failure);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  editAthleteProfile(context) async {
    Map<String, dynamic> mapData = {
      'profile': {"profile_photo": createdFullLicence!.profile!.profilePhoto},
      'athlete': {
        "photo": createdFullLicence!.athlete!.photo,
        "identity_photo": createdFullLicence!.athlete!.identityPhoto,
        "medical_photo": createdFullLicence!.athlete!.medicalPhoto,
      }
    };
    Response res = await licenceNetwork.editAthleteProfile(
        mapData, selectedFullLicence!.athlete!.id);
    if (res.statusCode == 200) {
      final snackBar = MySnackBar(
          title: "Modification Succees",
          msg: "La licence de ce athlete a ete modifie avec succees",
          state: ContentType.success);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notifyListeners();
    } else {
      final snackBar = MySnackBar(
          title: "Modification Echec",
          msg: "Echec de modification de licence merci de verifier vos donnee",
          state: ContentType.failure);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  editArbitratorProfile(context) async {
    Map<String, dynamic> mapData = {
      'profile': {"profile_photo": createdFullLicence!.profile!.profilePhoto},
      'arbitrator': {
        "photo": createdFullLicence!.arbitrator!.photo,
        "identity_photo": createdFullLicence!.arbitrator!.identityPhoto,
      }
    };
    Response res = await licenceNetwork.editArbitratorProfile(
        mapData, selectedFullLicence!.arbitrator!.id);
    if (res.statusCode == 200) {
      final snackBar = MySnackBar(
          title: "Modification Succees",
          msg: "La licence de ce arbitre a ete modifie avec succees",
          state: ContentType.success);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notifyListeners();
    } else {
      final snackBar = MySnackBar(
          title: "Modification Echec",
          msg: "Echec de modification de licence merci de verifier vos donnee",
          state: ContentType.failure);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  editCoachProfile(context) async {
    Map<String, dynamic> mapData = {
      'profile': {"profile_photo": createdFullLicence!.profile!.profilePhoto},
      'coach': {
        "photo": createdFullLicence!.coach!.photo,
        "identity_photo": createdFullLicence!.coach!.identityPhoto,
      }
    };
    Response res = await licenceNetwork.editCoachProfile(
        mapData, selectedFullLicence!.coach!.id);
    if (res.statusCode == 200) {
      final snackBar = MySnackBar(
          title: "Modification Succees",
          msg: "La licence de ce entraineur a ete modifie avec succees",
          state: ContentType.success);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notifyListeners();
    } else {
      final snackBar = MySnackBar(
          title: "Modification Echec",
          msg: "Echec de modification de licence merci de verifier vos donnee",
          state: ContentType.failure);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  editLicenceArbitrator(
    context,
  ) async {
    late Season s;
    for (Season season in parameters!.seasons!) {
      if (season.seasons == selectedFullLicence!.licence!.seasons) {
        s = season;
        selectedFullLicence!.licence!.seasons = season.id;
      }
    }
    selectedFullLicence!.licence!.role = 1;
    selectedFullLicence!.licence!.grade = selectedGrade!.id;
    if (currentUser.club!.id == null) {
      if (selectedClub!.id != -1) {
        selectedFullLicence!.licence!.club = selectedClub!.id;
        selectedFullLicence!.arbitrator!.club = selectedClub!.id;
      } else {
        selectedFullLicence!.licence!.club = null;
        selectedFullLicence!.arbitrator!.club = null;
      }
    } else {
      selectedFullLicence!.licence!.club = currentUser.club!.id;
      selectedFullLicence!.arbitrator!.club = currentUser.club!.id;
    }
    selectedFullLicence!.arbitrator!.grade = selectedGrade!.id;
    Map<String, dynamic> licenceData = selectedFullLicence!.licence!.toJson();
    selectedFullLicence!.licence!.grade = selectedGrade!.grade;
    selectedFullLicence!.licence!.club = selectedClub!.name;
    selectedFullLicence!.licence!.role = "حكم";
    selectedFullLicence!.licence!.seasons = s.seasons;
    Map<String, dynamic> arbitratorData =
        selectedFullLicence!.arbitrator!.toJson();
    Map<String, dynamic> mapData = {
      'licence': licenceData,
      'arbitrator': arbitratorData
    };
    Response res = await licenceNetwork.editArbitratorLicence(mapData);
    if (res.statusCode == 200) {
      final snackBar = MySnackBar(
          title: "Modification Succees",
          msg: "La licence de ce arbitre a ete modifie avec succees",
          state: ContentType.success);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notifyListeners();
    } else {
      final snackBar = MySnackBar(
          title: "Modification Echec",
          msg: "Echec de modification de licence merci de verifier vos donnee",
          state: ContentType.failure);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  editLicenceCoach(
    context,
  ) async {
    late Season s;
    for (Season season in parameters!.seasons!) {
      if (season.seasons == selectedFullLicence!.licence!.seasons) {
        s = season;
        selectedFullLicence!.licence!.seasons = season.id;
      }
    }
    // selectedFullLicence!.licence!.categorie = selectedCategory!.id;
    selectedFullLicence!.licence!.role = 4;
    // selectedFullLicence.profile.birthday
    selectedFullLicence!.licence!.grade = selectedGrade!.id;
    // selectedFullLicence!.licence!.weight = selectedWeight!.id;
    selectedFullLicence!.licence!.degree = selectedDegree!.id;
    selectedFullLicence!.licence!.discipline = selectedDiscipline!.id;
    if (currentUser.club!.id == null) {
      if (selectedClub!.id != -1) {
        selectedFullLicence!.licence!.club = selectedClub!.id;
        selectedFullLicence!.coach!.club = selectedClub!.id;
      } else {
        selectedFullLicence!.licence!.club = null;
        selectedFullLicence!.coach!.club = null;
      }
    } else {
      selectedFullLicence!.licence!.club = currentUser.club!.id;
      selectedFullLicence!.coach!.club = currentUser.club!.id;
    }

    // selectedFullLicence!.coach!.categoryId = selectedCategory!.id;
    selectedFullLicence!.coach!.grade = selectedGrade!.id;
    // selectedFullLicence!.coach!.weights = selectedWeight!.id;
    selectedFullLicence!.coach!.degree = selectedDegree!.id;
    selectedFullLicence!.coach!.discipline = selectedDiscipline!.id;
    Map<String, dynamic> licenceData = selectedFullLicence!.licence!.toJson();
    // selectedFullLicence!.licence!.categorie = selectedCategory!.categorieAge;
    selectedFullLicence!.licence!.grade = selectedGrade!.grade;
    // selectedFullLicence!.licence!.weight = null;
    selectedFullLicence!.licence!.degree = selectedDegree!.degree;
    selectedFullLicence!.licence!.discipline = selectedDiscipline!.name;
    selectedFullLicence!.licence!.club = selectedClub!.name;
    selectedFullLicence!.licence!.role = "مدرب";
    selectedFullLicence!.licence!.seasons = s.seasons;
    Map<String, dynamic> coachData = selectedFullLicence!.coach!.toJson();
    Map<String, dynamic> mapData = {'licence': licenceData, 'coach': coachData};
    Response res = await licenceNetwork.editCoachLicence(mapData);
    if (res.statusCode == 200) {
      final snackBar = MySnackBar(
          title: "Modification Succees",
          msg: "La licence de ce entraineur a ete modifie avec succees",
          state: ContentType.success);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notifyListeners();
    } else {
      final snackBar = MySnackBar(
          title: "Modification Echec",
          msg: "Echec de modification de licence merci de verifier vos donnee",
          state: ContentType.failure);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  editArbitratorImages(context) async {
    Map<String, dynamic> mapData = {
      'profile': {"profile_photo": createdFullLicence!.profile!.profilePhoto},
      'arbitrator': {
        "photo": createdFullLicence!.arbitrator!.photo,
        "identity_photo": createdFullLicence!.arbitrator!.identityPhoto,
      }
    };
    Response res = await licenceNetwork.editArbitratorProfile(
        mapData, selectedFullLicence!.arbitrator!.id);
    if (res.statusCode == 200) {
      final snackBar = MySnackBar(
          title: "Modification Succees",
          msg: "La licence de ce arbitre a ete modifie avec succees",
          state: ContentType.success);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notifyListeners();
    } else {
      final snackBar = MySnackBar(
          title: "Modification Echec",
          msg: "Echec de modification de licence merci de verifier vos donnee",
          state: ContentType.failure);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  editCoachImages(context) async {
    Map<String, dynamic> mapData = {
      'profile': {"profile_photo": createdFullLicence!.profile!.profilePhoto},
      'coach': {
        "photo": createdFullLicence!.coach!.photo,
        "identity_photo": createdFullLicence!.coach!.identityPhoto,
        "degree_photo": createdFullLicence!.coach!.degreePhoto,
        "grade_photo": createdFullLicence!.coach!.gradePhoto,
      }
    };
    Response res = await licenceNetwork.editCoachProfile(
        mapData, selectedFullLicence!.coach!.id);
    if (res.statusCode == 200) {
      final snackBar = MySnackBar(
          title: "Modification Succees",
          msg: "La licence de ce entraineur a ete modifie avec succees",
          state: ContentType.success);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notifyListeners();
    } else {
      final snackBar = MySnackBar(
          title: "Modification Echec",
          msg: "Echec de modification de licence merci de verifier vos donnee",
          state: ContentType.failure);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  editAthleteImages(context) async {
    Map<String, dynamic> mapData = {
      "photo": createdFullLicence!.athlete!.photo,
      "identity_photo": createdFullLicence!.athlete!.identityPhoto,
      "medical_photo": createdFullLicence!.athlete!.medicalPhoto,
    };
    Response res = await licenceNetwork.editAthleteProfile(
        mapData, selectedFullLicence!.athlete!.id);
    if (res.statusCode == 200) {
      final snackBar = MySnackBar(
          title: "Modification Succees",
          msg: "La licence de ce athlete a ete modifie avec succees",
          state: ContentType.success);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      notifyListeners();
    } else {
      final snackBar = MySnackBar(
          title: "Modification Echec",
          msg: "Echec de modification de licence merci de verifier vos donnee",
          state: ContentType.failure);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  // editArbitreImages(context) async {
  //   Map<String, dynamic> mapData = {
  //     "photo": createdFullLicence!.arbitrator!.photo,
  //     "identity_photo": createdFullLicence!.arbitrator!.identityPhoto,
  //     // "medical_photo": createdFullLicence!.arbitrator!.medicalPhoto,
  //   };
  //   Response res = await licenceNetwork.editArbitreProfile(
  //       mapData, selectedFullLicence!.arbitrator!.id);
  //   if (res.statusCode == 200) {
  //     ////print('ok');
  //     final snackBar = MySnackBar(
  //         title: "Modification Succees",
  //         msg: "La licence de ce arbitre a ete modifie avec succees",
  //         state: ContentType.success);
  //     ScaffoldMessenger.of(context)
  //       ..hideCurrentSnackBar()
  //       ..showSnackBar(snackBar);
  //     notifyListeners();
  //   } else {
  //     final snackBar = MySnackBar(
  //         title: "Modification Echec",
  //         msg: "Echec de modification de licence merci de verifier vos donnee",
  //         state: ContentType.failure);
  //     ScaffoldMessenger.of(context)
  //       ..hideCurrentSnackBar()
  //       ..showSnackBar(snackBar);
  //   }
  // }

  renewLicecne(context) async {
    Map<String, dynamic> mapData = {
      'degree': selectedDegree!.id,
      'grade': selectedGrade!.id,
      'discipline': selectedDiscipline!.id,
      'weight': selectedWeight!.id,
      'club': selectedClub!.id,
      'categorie': selectedCategory!.id,
      'state': "في الانتظار",
      'activated': false
    };
    try {
      Response res = await licenceNetwork.renewLicence(
          mapData, selectedFullLicence!.licence!.numLicences);
      if (res.statusCode == 200) {
        final snackBar = MySnackBar(
            title: "Renouvellement Succees",
            msg: "La licence de ce athlete a ete renouvelee avec succees",
            state: ContentType.success);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        notifyListeners();
      } else {
        final snackBar = MySnackBar(
            title: "Renouvellement Echec",
            msg: "Echec de renouvelee de licence merci de verifier vos donnee",
            state: ContentType.failure);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = MySnackBar(
          title: "Probleme",
          msg: "Il ya une probleme merci de ressayer ulterieurment",
          state: ContentType.failure);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  renewArbitratorLicecne(context) async {
    Map<String, dynamic> mapData = {
      'grade': selectedGrade!.id,
      'club': selectedClub!.id,
    };
    try {
      Response res = await licenceNetwork.renewArbitratorLicence(
          mapData, selectedFullLicence!.licence!.numLicences);
      if (res.statusCode == 200) {
        final snackBar = MySnackBar(
            title: "Renouvellement Succees",
            msg: "La licence de ce arbitre a ete renouvelee avec succees",
            state: ContentType.success);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        notifyListeners();
      } else {
        final snackBar = MySnackBar(
            title: "Renouvellement Echec",
            msg: "Echec de renouvelee de licence merci de verifier vos donnee",
            state: ContentType.failure);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = MySnackBar(
          title: "Probleme",
          msg: "Il ya une probleme merci de ressayer ulterieurment",
          state: ContentType.failure);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  renewCoachLicecne(context) async {
    Map<String, dynamic> mapData = {
      'degree': selectedDegree!.id,
      'grade': selectedGrade!.id,
      'discipline': selectedDiscipline!.id,
      'weight': selectedWeight!.id,
      'club': selectedClub!.id,
      'categorie': selectedCategory!.id,
    };
    try {
      Response res = await licenceNetwork.renewCoachLicence(
          mapData, selectedFullLicence!.licence!.numLicences);
      if (res.statusCode == 200) {
        final snackBar = MySnackBar(
            title: "Renouvellement Succees",
            msg: "La licence de ce entraineur a ete renouvelee avec succees",
            state: ContentType.success);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        notifyListeners();
      } else {
        final snackBar = MySnackBar(
            title: "Renouvellement Echec",
            msg: "Echec de renouvelee de licence merci de verifier vos donnee",
            state: ContentType.failure);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = MySnackBar(
          title: "Probleme",
          msg: "Il ya une probleme merci de ressayer ulterieurment",
          state: ContentType.failure);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  // filterLicences(context) {
  //   if ((selectedCategory!.id != -1) ||
  //       (selectedClub!.id != -1) ||
  //       (selectedDegree!.id != -1) ||
  //       (selectedDiscipline!.id != -1) ||
  //       (selectedGrade!.id != -1) ||
  //       (selectedWeight!.id != -1) ||
  //       (selectedSeason!.id != -1) ||
  //       (selectedSex != "الجنس") ||
  //       (filteredRole!.id != -1) ||
  //       (selectedStatus != "الحالة")) {
  //     Navigator.pop(context);
  //     GoRouter.of(context).push(Routes.FilteredLicencesScreen);
  //     filteredFullLicences.clear();
  //     for (var element in fullLicences) {
  //       filteredFullLicences.add(element);
  //     }
  //     if (selectedCategory!.id != -1) {
  //       int i = 0;
  //       while (i < filteredFullLicences.length) {
  //         if (filteredFullLicences[i].licence!.categorie !=
  //             selectedCategory!.categorieAge) {
  //           filteredFullLicences.remove(filteredFullLicences[i]);
  //         } else {
  //           i++;
  //         }
  //         notifyListeners();
  //       }
  //     }
  //     if (filteredRole!.id != -1) {
  //       int i = 0;
  //       while (i < filteredFullLicences.length) {
  //         if (filteredFullLicences[i].licence!.role !=
  //             filteredRole!.roles) {
  //           filteredFullLicences.remove(filteredFullLicences[i]);
  //         } else {
  //           i++;
  //         }
  //         notifyListeners();
  //       }
  //     }
  //     if (selectedClub!.id != -1) {
  //       int i = 0;
  //       while (i < filteredFullLicences.length) {
  //         if (filteredFullLicences[i].licence!.club != selectedClub!.name) {
  //           filteredFullLicences.remove(filteredFullLicences[i]);
  //         } else {
  //           i++;
  //         }
  //         notifyListeners();
  //       }
  //     }
  //     if (selectedDegree!.id != -1) {
  //       int i = 0;
  //       while (i < filteredFullLicences.length) {
  //         if (filteredFullLicences[i].licence!.degree !=
  //             selectedDegree!.degree) {
  //           filteredFullLicences.remove(filteredFullLicences[i]);
  //         } else {
  //           i++;
  //         }
  //         notifyListeners();
  //       }
  //     }
  //     if (selectedDiscipline!.id != -1) {
  //       int i = 0;
  //       while (i < filteredFullLicences.length) {
  //         if (filteredFullLicences[i].licence!.discipline !=
  //             selectedDiscipline!.name) {
  //           filteredFullLicences.remove(filteredFullLicences[i]);
  //         } else {
  //           i++;
  //         }
  //         notifyListeners();
  //       }
  //     }
  //     if (selectedGrade!.id != -1) {
  //       int i = 0;
  //       while (i < filteredFullLicences.length) {
  //         if (filteredFullLicences[i].licence!.grade != selectedGrade!.grade) {
  //           filteredFullLicences.remove(filteredFullLicences[i]);
  //         } else {
  //           i++;
  //         }
  //         notifyListeners();
  //       }
  //     }
  //     if (selectedWeight!.id != -1) {
  //       int i = 0;
  //       while (i < filteredFullLicences.length) {
  //         if (filteredFullLicences[i].licence!.weight != null) {
  //           if (filteredFullLicences[i].licence!.weight!.toString() !=
  //               selectedWeight!.masseEnKillograme.toString()) {
  //             filteredFullLicences.remove(filteredFullLicences[i]);
  //           } else {
  //             i++;
  //           }
  //         } else {
  //           i++;
  //         }
  //         notifyListeners();
  //       }
  //     }
  //     if (selectedSeason!.id != -1) {
  //       int i = 0;
  //       while (i < filteredFullLicences.length) {
  //         if (filteredFullLicences[i].licence!.seasons !=
  //             selectedSeason!.seasons) {
  //           filteredFullLicences.remove(filteredFullLicences[i]);
  //         } else {
  //           i++;
  //         }
  //         notifyListeners();
  //       }
  //     }
  //     if (selectedSex != "الجنس") {
  //       int i = 0;
  //       while (i < filteredFullLicences.length) {
  //         if (filteredFullLicences[i].profile!.sexe != selectedSex) {
  //           filteredFullLicences.remove(filteredFullLicences[i]);
  //         } else {
  //           i++;
  //         }
  //         notifyListeners();
  //       }
  //     }
  //     if (selectedStatus != "الحالة") {
  //       int i = 0;
  //       while (i < filteredFullLicences.length) {
  //         if (filteredFullLicences[i].licence!.state != selectedStatus) {
  //           filteredFullLicences.remove(filteredFullLicences[i]);
  //         } else {
  //           i++;
  //         }
  //         notifyListeners();
  //       }
  //     }
  //   } else {
  //     Navigator.pop(context);
  //     final snackBar = MySnackBar(
  //         title: "Pas de filtrage",
  //         msg: "Merci d'appliquer un filtre",
  //         state: ContentType.warning);
  //     ScaffoldMessenger.of(context)
  //       ..hideCurrentSnackBar()
  //       ..showSnackBar(snackBar);
  //   }
  // }

  getGeneralStats() async {
    Response res = await licenceNetwork.getGeneralStats();
    if (res.statusCode == 200) {
      stats = Stats.fromJson(res.data);
      // notify();
      return stats;
    } else {
      notify();
      return false;
    }
  }

  getClubStats() async {
    Response res = await licenceNetwork.getClubStats(currentUser.club!.id);
    if (res.statusCode == 200) {
      stats = Stats.fromJson(res.data);
      // notify();
      return stats;
    } else {
      notify();
      return false;
    }
  }

  // exportToExcel(){
  //   //print('exporting');
  //   final Workbook workbook = Workbook();
  //   //Accessing worksheet via index.
  //   workbook.worksheets[0];
  //   // Save the document.
  //   final List<int> bytes = workbook.saveAsStream();
  //   File('CreateExcel.xlsx').writeAsBytes(bytes);
  //   //Dispose the workbook.
  //   workbook.dispose();
  // }

  void exportAthletesToExcel(String fileName, int index, context, date) async {
    Map<String, dynamic> mapData = {
      "season": selectedSeason!.id,
      "role": selectedRole.id,
      "userid": currentUser.id,
      "start": date??"",
      "state":(selectedStatus=="الحالة")?"":selectedStatus,
      "categorie":(selectedCategory!.id==-1)?"":selectedCategory!.id,
      "club": (selectedClub!.id==-1)?"":selectedClub!.id
    };
    // licenceNetwork.getLicenceListInfo(mapData);
    print(mapData);
    await getLicences(mapData);
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];
    if (selectedRole.id == 2) {
      sheet.appendRow([
        TextCellValue("saison"),
        TextCellValue("n_lic"),
        TextCellValue("cin"),
        TextCellValue("nom"),
        TextCellValue("prenom"),
        TextCellValue("sexe"),
        TextCellValue("naissance"),
        TextCellValue("age"),
        TextCellValue("club"),
        TextCellValue("ligue"),
        // TextCellValue("n"),
        TextCellValue("photoid"),
        // TextCellValue("type"),
        TextCellValue("sport"),
        // TextCellValue("grade"),
        TextCellValue("nationalite"),

        // TextCellValue("grade_arbitrage"),
        TextCellValue("date_sais")
      ]); // Replace with your column names

      // Add data
      for (int index = 0; index < exportFullLicences.length; index++) {
        sheet.appendRow([
          TextCellValue(exportFullLicences[index].licence!.seasons??""),
          TextCellValue(exportFullLicences[index].licence!.numLicences??""),
          TextCellValue(exportFullLicences[index].profile!.cin??""),
          TextCellValue(exportFullLicences[index].profile!.firstName??""),
          TextCellValue(exportFullLicences[index].profile!.lastName??""),
          TextCellValue(exportFullLicences[index].profile!.sexe??""),
          TextCellValue(exportFullLicences[index].profile!.birthday??""),
          TextCellValue(exportFullLicences[index].licence!.categorie??""),
          TextCellValue(exportFullLicences[index].licence!.club??""),
          TextCellValue(exportFullLicences[index].profile!.state ?? ""),
          // TextCellValue('0'),
          TextCellValue(exportFullLicences[index].profile!.profilePhoto??""),
          // TextCellValue(exportFullLicences[index].licence!.role),
          TextCellValue(exportFullLicences[index].licence!.discipline??""),
          // TextCellValue(exportFullLicences[index].licence!.grade ?? ""),
          TextCellValue("التونسية"),

          // (exportFullLicences[index].licence!.role == "رياضي")
          // ?
          TextCellValue(exportFullLicences[index].licence!.created??"")
          // : TextCellValue("")
        ]); // Replace with your data structure
      }
    } else if (selectedRole.id == 4) {
      
      sheet.appendRow([
        TextCellValue("saison"),
        TextCellValue("nom"),
        TextCellValue("prenom"),
        TextCellValue("club"),
        TextCellValue("ligue"),
        TextCellValue("n"),
        TextCellValue("photo"),
        TextCellValue("type"),
        TextCellValue("discipline"),
        TextCellValue("grade"),
        TextCellValue("degre"),
        TextCellValue("lic"),
        TextCellValue("sexe"),
        TextCellValue("date_naissance"),
        // TextCellValue("grade_arbitrage"),
        TextCellValue("date_sais"),
        TextCellValue("cin"),
      ]); // Replace with your column names

      // Add data
      for (int index = 0; index < exportFullLicences.length; index++) {
        sheet.appendRow([
          TextCellValue(exportFullLicences[index].licence!.seasons??""),
          TextCellValue(exportFullLicences[index].profile!.firstName??""),
          TextCellValue(exportFullLicences[index].profile!.lastName??""),
          TextCellValue(exportFullLicences[index].licence!.club??""),
          TextCellValue(exportFullLicences[index].profile!.state ?? ""),
          TextCellValue('0'),

          TextCellValue(exportFullLicences[index].profile!.profilePhoto??""),
          TextCellValue(exportFullLicences[index].licence!.role??""),
          TextCellValue(exportFullLicences[index].licence!.discipline??""),
          TextCellValue(exportFullLicences[index].licence!.grade ?? ""),

          TextCellValue(exportFullLicences[index].licence!.degree ?? ""),
          TextCellValue(exportFullLicences[index].licence!.numLicences??""),

          TextCellValue(exportFullLicences[index].profile!.sexe??""),
          TextCellValue(exportFullLicences[index].profile!.birthday??""),

          // (exportFullLicences[index].licence!.role == "رياضي")
          // ?
          TextCellValue(exportFullLicences[index].licence!.created??""),
          // : TextCellValue("")
          TextCellValue(exportFullLicences[index].profile!.cin??""),
        ]); // Replace with your data structure
      }
    } else if (selectedRole.id == 1) {
      sheet.appendRow([
        TextCellValue("saison"),
        TextCellValue("nom"),
        TextCellValue("prenom"),
        TextCellValue("club"),
        TextCellValue("ligue"),
        TextCellValue("n"),
        TextCellValue("photo"),
        TextCellValue("type"),
        // TextCellValue("discipline"),
        TextCellValue("lic"),
        TextCellValue("sexe"),
        TextCellValue("date_naissance"),
        TextCellValue("grade_arbitrage"),
        TextCellValue("date_sais"),
        TextCellValue("cin"),
      ]); // Replace with your column names

      // Add data
      for (int index = 0; index < exportFullLicences.length; index++) {
        sheet.appendRow([
          TextCellValue(exportFullLicences[index].licence!.seasons??""),
          TextCellValue(exportFullLicences[index].profile!.firstName??""),
          TextCellValue(exportFullLicences[index].profile!.lastName??""),
          TextCellValue(exportFullLicences[index].licence!.club??""),
          TextCellValue(exportFullLicences[index].profile!.state ?? ""),
          TextCellValue('0'),

          TextCellValue(exportFullLicences[index].profile!.profilePhoto??""),
          TextCellValue(exportFullLicences[index].licence!.role??""),
          // TextCellValue(exportFullLicences[index].licence!.discipline),

          TextCellValue(exportFullLicences[index].licence!.numLicences??""),

          TextCellValue(exportFullLicences[index].profile!.sexe??""),
          TextCellValue(exportFullLicences[index].profile!.birthday??""),
          TextCellValue(exportFullLicences[index].licence!.grade ?? ""),

          // (exportFullLicences[index].licence!.role == "رياضي")
          // ?
          TextCellValue(exportFullLicences[index].licence!.created??""),
          // : TextCellValue("")
          TextCellValue(exportFullLicences[index].profile!.cin??""),
        ]); // Replace with your data structure
      }
    }
    // Add headers

    // Save the Excel file
    await Directory('excel_exports').create(); // create directory if not exists
    var file = '$fileName.xlsx';
    var filePath = p.join('excel_exports', file);
    // excel.encode();
    // var fileBytes = excel.save(fileName: 'My_Excel_File_Name.xlsx');
    final bytes = await excel.encode();
    File(filePath).writeAsBytes(bytes!);
    final snackBar = MySnackBar(
      title: 'نجاح الاستخراج',
      msg: 'تم استخراج البيانات بنجاح',
      state: ContentType.success,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    // excel.encode().then((onValue) {
    //   File(filePath)
    //     ..createSync(recursive: true)
    //     ..writeAsBytesSync(onValue);
    // });
  }
  createDefaultCoach(){
    Map<String,dynamic> mapData;
    // licenceNetwork.createDefaultCoach(mapData);
  }

  getCoachClubs(){
    List<Club> clubsList=[];
    print(selectedFullLicence!.coach!.clubs);
    List<String> clubs=selectedFullLicence!.coach!.clubs.split(",");
    for(int i=0;i<clubs.length;i++){
      clubsList.add(parameters!.clubs!.firstWhere((element) => element.id.toString()==clubs[i]));
    }
    return clubsList;
  }

  assignClubToCoach(context) async {
    Map<String,dynamic> mapData={
      "coach":{"id":selectedFullLicence!.coach!.id},
      "licence":selectedFullLicence!.licence!.numLicences,
      "club":selectedClub!.id.toString()
    };
    Response res=await licenceNetwork.assignClubToCoach(mapData);
    if(res.statusCode==200){
      // fullLicences.add()
      final snackBar = MySnackBar(
      title: 'نجاح الاستخراج',
      msg: 'تم استخراج البيانات بنجاح',
      state: ContentType.success,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
      
    }
    else{
      final snackBar = MySnackBar(
      title: 'Problem',
      msg: 'Couldn\'t add club',
      state: ContentType.failure,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    }

  }
}
