import 'dart:developer';
import 'dart:typed_data';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/models/coach.dart';
import 'package:fu_licences/models/full_licence.dart';
import 'package:fu_licences/models/licence.dart';
import 'package:fu_licences/models/parameters.dart';
import 'package:fu_licences/models/user.dart';
import 'package:fu_licences/network/apis.dart';
import 'package:fu_licences/network/licence_network.dart';
import 'package:fu_licences/router/pages.dart';
import 'package:fu_licences/screens/auth/login_Screen.dart';
import 'package:fu_licences/screens/home/home_screen.dart';
import 'package:fu_licences/screens/licence/licence_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_windows/image_picker_windows.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
// import 'package:image_picker/image_picker.dart';

import '../router/routes.dart';
import '../screens/licence/filtered_licences_list.dart';
import '../widgets/global/snackbars.dart';
import '../widgets/licence/licence_widget.dart';

class LicenceProvider extends ChangeNotifier {
  bool isShadow=false;
  List<bool> isHovered=[false,false,false,false,false];
  List<Widget> myItems=[];
   Widget next=Container();
  bool isLoading=true;
  late User currentUser;
  late Role selectedRole;
  bool added = false;
  Season? selectedSeason = Season(seasons: "Saison", id: -1);
  Category? selectedCategory = Category(categorieAge: "Catgorie", id: -1);
  Grade? selectedGrade = Grade(grade: "Grade", id: -1);
  Ligue? selectedLigue = Ligue(name: "Ligue", id: -1);
  Degree? selectedDegree = Degree(degree: "Degree", id: -1);
  Weight? selectedWeight = Weight(masseEnKillograme: 0, id: -1);
  Discipline? selectedDiscipline = Discipline(name: "Discipline", id: -1);
  Club? selectedClub = Club(name: "Club", id: -1);
  Category? filteredCategory = Category(categorieAge: "Catgorie", id: -1);
  Grade? filteredGrade = Grade(grade: "Grade", id: -1);
  Degree? filteredDegree = Degree(degree: "Degree", id: -1);
  Weight? filteredWeight = Weight(masseEnKillograme: 0, id: -1);
  Discipline? filteredDiscipline = Discipline(name: "Discipline", id: -1);
  Club? filteredClub = Club(name: "Club", id: -1);
  String filteredSex = "Sexe";
  String filteredStatus = "Etat";
  String selectedStatus = "Etat";
  DateTime? selectedBirth;
  String selectedSex = "Sexe";
  String selectedState = "Governorat";
  Apis apis = Apis();
  late  SharedPreferences prefs;

  FullLicence? createdFullLicence = FullLicence(
      profile: Profile(),
      licence: Licence(),
      user: User(),
      arbitrator: Arbitrator(),
      athlete: Athlete(),
      coach: Coach());
          final picker = ImagePickerWindows();

  // final ImagePicker _picker = ImagePicker();
  Parameters? parameters;
  List<FullLicence> fullLicences = [];
  List<FullLicence> filteredFullLicences = [];

  LicenceNetwork licenceNetwork = LicenceNetwork();
  FullLicence? selectedFullLicence;



  login(context,login,password) async {
    
    print('ddd');
    try{
      Map<String,dynamic> data={
      "username":login,
      "password":password
    };
      Response res=await licenceNetwork.login(data);
      print('eee');
    if(res.statusCode==200){
      if(res.data!=null){
        Apis.tempToken='TOKEN '+res.data['token'];
        currentUser=User.fromJson(res.data);
         prefs= await SharedPreferences.getInstance();
         prefs.setString('user', login);
         prefs.setString('psd', password);
         print(Apis.tempToken);
        // print()
         print('ffff');

        // print(licenceNetwork.apis.tempToken);
        // print(currentUser.club!.id.toString());
        GoRouter.of(context).go(Routes.Home);
      }
    }
    else{
      final snackBar = MySnackBar(
          title: 'Echec',
          msg: 'Le numero ou mot de passe est incorrecte',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          state: ContentType.failure,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
    }
    catch(e){
      final snackBar = MySnackBar(
          title: 'Echec',
          msg: 'Le numero ou mot de passe est incorrecte',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          state: ContentType.failure,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
    }
    
  } 

  clearPrefs() async {
    prefs=await SharedPreferences.getInstance();
    prefs.clear();
  }
  checkLogin(context) async {
    prefs=await SharedPreferences.getInstance();
    if (prefs.containsKey('user') && prefs.getString('user')!=null && prefs.getString('user')!=""){
      next=HomeScreen();
      // Pages.root=Routes.Home;

      login(context, prefs.getString('user'), prefs.getString('psd'));
      // GoRouter.of(context).go(Routes.Home);
    }
    else{
      next=LoginScreen();
      // Pages.root=Routes.Login;
      GoRouter.of(context).go(Routes.Login);
   // }
    return true;
    // else{
      
     }
  }
  logout(context) async {
    prefs=await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.remove('psd');
    GoRouter.of(context).go(Routes.Login);
  }


  showImage(context,img){
    showDialog(context: context, builder: (context){
      return Dialog(
        child: Image.network(img),
      );
    });
  }

  validateLicence(context) async {
     Response res = await licenceNetwork.validateLicence(selectedFullLicence!.licence!.numLicences);
     if (res.statusCode == 200) {
      if (res.data != null) {
        selectedFullLicence!.licence!.activated=true;
        selectedFullLicence!.licence!.state="Activee";
        notify();
        final snackBar = MySnackBar(
          title: 'Succees',
          msg: 'La licence de ce athlete a ete ajoute avec succees',
          
          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          state: ContentType.success,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
      else{
        final snackBar = MySnackBar(
          title: 'Echec',
          msg: 'L\'activation de cette licence a echoue',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
          state: ContentType.failure,
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
     }
  }

  getLicences() async {
    // isLoading=true;
    // notify();
    if (fullLicences.length > 0) {
      fullLicences.clear();
    }
    Response res = await licenceNetwork.getLicenceListInfo(currentUser.club!.id??"");
    if (res.statusCode == 200) {
      if (res.data != null) {
        for (var r in res.data) {
          if(r['profile']!=null){
          FullLicence fullLicence = FullLicence();
          
          Profile profile = Profile.fromJson(r['profile']);
          fullLicence.profile = profile;
          Licence licence = Licence.fromJson(r['licence']);
          fullLicence.licence = licence;
          if (licence.role == "Athlete") {
            Athlete athlete = Athlete.fromJson(r['data']);
            fullLicence.athlete = athlete;
          } else if (licence.role == "Arbitre") {
            Arbitrator arbitrator = Arbitrator.fromJson(r['data']);
            fullLicence.arbitrator = arbitrator;
          } else if (licence.role == "Entraineur") {
            Coach coach = Coach.fromJson(r['data']);
            fullLicence.coach = coach;
          }
          fullLicences.add(fullLicence);
        }}
        print(fullLicences.length);
        notify();
      }
    }
    isLoading=false;
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
    selectedSeason = Season(seasons: "Saison", id: -1);
    selectedCategory = Category(categorieAge: "Catgorie", id: -1);
    selectedGrade = Grade(grade: "Grade", id: -1);
    selectedDegree = Degree(degree: "Degree", id: -1);
    selectedWeight = Weight(masseEnKillograme: 0, id: -1);
    selectedDiscipline = Discipline(name: "Discipline", id: -1);
    selectedClub = Club(name: "Club", id: -1);
    selectedState = 'Governorat';
    selectedSex = 'Sexe';
  }

  getParameters() async {
    Response res = await licenceNetwork.getParameters();
    if (res.statusCode == 200) {
      if (res.data != null) {
        parameters = Parameters();
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

        List<Club> clubs = [];
        for (var l in res.data['Clubs']) {
          Club club = Club.fromJson(l);
          clubs.add(club);
        }
        parameters!.clubs = clubs;

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
        }
        parameters!.seasons = seasons;
        print(parameters.toString());
        notify();
      }
    }
  }

  notify() {
    notifyListeners();
  }

  getCoachImagePath(String? toFillImage) {
    print('entered get coach');
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
      print(createdFullLicence!.profile!.profilePhoto);
    } else if (toFillImage == 'idphoto') {
      createdFullLicence!.coach!.identityPhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
      print(createdFullLicence!.coach!.identityPhoto);
    } else if (toFillImage == "photo") {
      createdFullLicence!.coach!.photo =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
      print(createdFullLicence!.coach!.photo);
    } else if (toFillImage == "gradephoto") {
      createdFullLicence!.coach!.gradePhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
      print(createdFullLicence!.coach!.gradePhoto);
    } else if (toFillImage == "degreephoto") {
      createdFullLicence!.coach!.degreePhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
      print(createdFullLicence!.coach!.degreePhoto);
    }
  }



  setArbitreImagePath(String? toFillImage, String url) {
    if (toFillImage == "profilePhoto") {
      createdFullLicence!.profile!.profilePhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
      print(createdFullLicence!.profile!.profilePhoto);
    } else if (toFillImage == 'idphoto') {
      createdFullLicence!.arbitrator!.identityPhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
      print(createdFullLicence!.arbitrator!.identityPhoto);
    } else if (toFillImage == "photo") {
      createdFullLicence!.arbitrator!.photo =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
      print(createdFullLicence!.arbitrator!.photo);
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
      print(createdFullLicence!.profile!.profilePhoto);
    } else if (toFillImage == 'idphoto') {
      createdFullLicence!.athlete!.identityPhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
      print(createdFullLicence!.athlete!.identityPhoto);
    } else if (toFillImage == "photo") {
      createdFullLicence!.athlete!.photo =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
      print(createdFullLicence!.athlete!.photo);
    } else if (toFillImage == "medphoto") {
      createdFullLicence!.athlete!.medicalPhoto =
          apis.baseUrl.substring(0, apis.baseUrl.length - 5) + url;
      print(createdFullLicence!.athlete!.medicalPhoto);
    }
  }

  pickEditImage(bool fromGallery, context, String? toFillImage) async {
    // final XFile? image;
      Uint8List? _imageBytes;

    // if (fromGallery) {
    //   image = await _picker.pickImage(source: ImageSource.gallery);
    // } else {
    //   image = await _picker.pickImage(source: ImageSource.camera);
    // }
    final picker = ImagePickerWindows();
    PickedFile? file = await picker.pickImage(source: ImageSource.gallery);
    print('done');
    String path = getAthleteImagePath(toFillImage);

    uploadEditImage(file, path, 6, toFillImage);
    Navigator.pop(context);
    // Response res=await licenceNetwork.uploadImage();
  }



  pickAthleteImage(bool fromGallery, context, String? toFillImage) async {
    
    final XFile? image;
    // if (fromGallery) {
    //   image = await _picker.pickImage(source: ImageSource.gallery);
    // } else {
    //   image = await _picker.pickImage(source: ImageSource.camera);
    // }
    print('done');
    Uint8List? _imageBytes;
    final picker = ImagePickerWindows();
    PickedFile? file = await picker.pickImage(source: ImageSource.gallery);
    String path = getAthleteImagePath(toFillImage);
    uploadAthleteImage(file!, path, 6, toFillImage);
    // Navigator.pop(context);
    // Response res=await licenceNetwork.uploadImage();
  }

pickArbitreImage(bool fromGallery, context, String? toFillImage) async {
    final PickedFile? image;
    // if (fromGallery) {
    //   image = await _picker.pickImage(source: ImageSource.gallery);
    // } else {
    //   image = await _picker.pickImage(source: ImageSource.camera);
    // }
    print('done');
    Uint8List? _imageBytes;
    final picker = ImagePickerWindows();
    PickedFile? file = await picker.pickImage(source: ImageSource.gallery);
    String path = getArbitreImagePath(toFillImage);

    uploadArbitreImage(file!, path, 6, toFillImage,context);
    // Navigator.pop(context);
    // Response res=await licenceNetwork.uploadImage();
  }


  pickCoachImage(bool fromGallery, context, String? toFillImage) async {
    final XFile? image;
    // if (fromGallery) {
    //   image = await _picker.pickImage(source: ImageSource.gallery);
    // } else {
    //   image = await _picker.pickImage(source: ImageSource.camera);
    // }

    Uint8List? _imageBytes;
    final picker = ImagePickerWindows();
    PickedFile? file = await picker.pickImage(source: ImageSource.gallery);
    String path = getCoachImagePath(toFillImage);
    print('path is'+path);
    await uploadCoachImage(file!, path, 6, toFillImage);
    // Navigator.pop(context);
    // Response res=await licenceNetwork.uploadImage();
  }

  uploadAthleteImage(PickedFile image, path, season, String? toFillImage) async {
    String fileName = image.path.split('/').last;
    // Map<String, dynamic> tempData = {
    //   "url": image.path,
    //   "path": path,
    //   "season": season,
    //   "user": 1
    // };
    print('map data ready');
    print(fileName.toString() +
        ' ' +
        image.path.toString() +
        ' ' +
        path.toString() +
        ' ' +
        season.toString());
    FormData formData = FormData.fromMap({
      "url": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
        // contentType:  MediaType("image", "jpeg"), //important
      ),
      "path": path,
      "season": season,
      "user": 1
    });
    print('form data ready');
    Response res = await licenceNetwork.uploadImage(formData);
    if (res.statusCode == 200) {
      if (res.data != null) {
        print('image uploaded');
        print(formData);
        print(res.data);
        setAthleteImagePath(toFillImage, res.data['url']);
        //toFillImage=res.data['url'];

        notify();
      }
    }
  }

  uploadArbitreImage(PickedFile image, path, season, String? toFillImage,context) async {
    String fileName = image.path.split('/').last;
    // Map<String, dynamic> tempData = {
    //   "url": image.path,
    //   "path": path,
    //   "season": season,
    //   "user": 1
    // };
    print('map data ready');
    print(fileName.toString() +
        ' ' +
        image.path.toString() +
        ' ' +
        path.toString() +
        ' ' +
        season.toString());
    FormData formData = FormData.fromMap({
      "url": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
        // contentType:  MediaType("image", "jpeg"), //important
      ),
      "path": path,
      "season": season,
      "user": 1
    });
    print('form data ready');
    Response res = await licenceNetwork.uploadImage(formData);
    if (res.statusCode == 200) {
      if (res.data != null) {

        print('image uploaded');
        print(formData);
        print(res.data);
        setArbitreImagePath(toFillImage, res.data['url']);
        // myItems.clear();
        // myItems=[
        //                             AthleteImageUploadWidget(
        //                                 'photo de profile',
        //                                 this,
        //                                 context,
        //                                 'profilePhoto',
        //                                 this.createdFullLicence!
        //                                     .profile!.profilePhoto),
        //                             AthleteImageUploadWidget(
        //                                 'photo d\'identite',
        //                                 this,
        //                                 context,
        //                                 'idphoto',
        //                                 this.createdFullLicence!
        //                                     .athlete!.identityPhoto),
        //                             AthleteImageUploadWidget(
        //                                 'photo d\'assurance',
        //                                 this,
        //                                 context,
        //                                 'photo',
        //                                 this.createdFullLicence!
        //                                     .athlete!.photo),
        //                             AthleteImageUploadWidget(
        //                                 'photo medical',
        //                                 this,
        //                                 context,
        //                                 'medphoto',
        //                                 this.createdFullLicence!
        //                                     .athlete!.medicalPhoto),
                                  // ];
        //toFillImage=res.data['url'];

        notify();
      }
    }
  }

  uploadCoachImage(PickedFile image, path, season, String? toFillImage) async {
    print('entered upload coach');
    String fileName = image.path.split('/').last;
    Map<String, dynamic> tempData = {
      "url": image.path,
      "path": path,
      "season": season,
      "user": 1
    };

    print('map data ready');
    print(fileName.toString() +
        ' ' +
        image.path.toString() +
        ' ' +
        path.toString() +
        ' ' +
        season.toString());
    // FormData formData = FormData.fromMap({
    //   "url": await MultipartFile.fromFile(
    //     image.path,
    //     filename: fileName,
    //     // contentType:  MediaType("image", "jpeg"), //important
    //   ),
    //   "path": path,
    //   "season": season,
    //   "user": 1
    // });
    FormData formData = FormData.fromMap({
      "url": await MultipartFile.fromFile(image.path, filename: fileName),
      "path": path,
      "season": season,
      "user": 1
    });
    print('form data ready');
    Response res = await licenceNetwork.uploadImage(formData);
    print('start uploading');
    if (res.statusCode == 200) {
      if (res.data != null) {
        print('image uploaded');
        print(formData);
        print(res.data);
        setCoachImagePath(toFillImage, res.data['url']);
        //toFillImage=res.data['url'];

        notify();
      }
    } else {
      print('problem' + res.statusCode.toString());
    }
    print('not uploaded');
  }

  uploadEditImage(PickedFile? image, path, season, String? toFillImage) async {
    String fileName = image!.path.split('/').last;
    Map<String, dynamic> tempData = {
      "url": image.path,
      "path": path,
      "season": season,
      "user": 1
    };
    FormData formData = FormData.fromMap({
      "url": await MultipartFile.fromFile(
        image.path,
        filename: fileName,
        // contentType:  MediaType("image", "jpeg"), //important
      ),
      "path": path,
      "season": season,
      "user": 1
    });
    Response res = await licenceNetwork.uploadImage(formData);
    if (res.statusCode == 200) {
      if (res.data != null) {
        print('image uploaded');
        print(formData);
        print(res.data);
        setAthleteImagePath(toFillImage, res.data['url']);
        //toFillImage=res.data['url'];

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
    createdFullLicence!.profile!.birthday = selectedBirth.toString();
    createdFullLicence!.profile!.cin = cin;
    // createdFullLicence!.profile!.country=address;
    createdFullLicence!.profile!.firstName = firstName;
    createdFullLicence!.profile!.lastName = lastName;
    createdFullLicence!.profile!.phone = int.parse(phone!);
    createdFullLicence!.profile!.role = 2;
    createdFullLicence!.profile!.sexe = selectedSex;
    createdFullLicence!.profile!.state = selectedState;
    User user = User(
        isSuperuser: false,
        username: createdFullLicence!.profile!.phone.toString(),
        password: "12345");
    createdFullLicence!.user = user;
    // createdFullLicence!.profile!.=address;
    // createdFullLicence!.profile!.user=user;
  }

  createCoachProfile(
      {String? address,
      String? cin,
      String? firstName,
      String? lastName,
      String? phone,
      String? state}) {
    createdFullLicence!.profile!.address = address;
    createdFullLicence!.profile!.birthday = selectedBirth.toString();
    createdFullLicence!.profile!.cin = cin;
    // createdFullLicence!.profile!.country=address;
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
    // createdFullLicence!.profile!.=address;
    // createdFullLicence!.profile!.user=user;
  }
  createArbitreProfile(
      {String? address,
      String? cin,
      String? firstName,
      String? lastName,
      String? phone,
      String? state}) {
    createdFullLicence!.profile!.address = address;
    createdFullLicence!.profile!.birthday = selectedBirth.toString();
    createdFullLicence!.profile!.cin = cin;
    // createdFullLicence!.profile!.country=address;
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
    // createdFullLicence!.profile!.=address;
    // createdFullLicence!.profile!.user=user;
  }
createArbitre(context) {
    // String? categoryId;
    // dynamic? gradeId;
    // dynamic? idDegree;
    // int? discipline;
    // int? profile;
    // dynamic? weights;
    // String? club;
    // User user=User(isSuperuser: false,username:createdFullLicence!.profile!.phone.toString(), password: "12345");
    // createdFullLicence!.arbitrator!.categoryId = selectedCategory!.id;
    createdFullLicence!.arbitrator!.grade = selectedGrade!.id;
    if(currentUser.club!.id==null){
      createdFullLicence!.arbitrator!.club = selectedClub!.id;
    }
    else{
      createdFullLicence!.arbitrator!.club = currentUser.club!.id;
    }
    // createdFullLicence!.profile!.country=address;
    // createdFullLicence!.arbitrator!.discipline = selectedDiscipline!.id;
    // createdFullLicence!.arbitrator!.weights = selectedWeight!.id;
    // createdFullLicence!.arbitrator!.idDegree = selectedDegree!.id;
    createArbitreLicence(context);
    // createdFullLicence!.athlete!.profile=createdFullLicence!.profile;
    // createdFullLicence!.profile!.sexe=selectedSex;
    // createdFullLicence!.profile!.state=state;
    // createdFullLicence!.user=user;
    // createdFullLicence!.profile!.=address;
    // createdFullLicence!.profile!.user=user;
  }

createArbitreLicence(context) async {
    added = true;
    // createdFullLicence!.licence!.categorie = selectedCategory!.id;
    createdFullLicence!.licence!.grade = selectedGrade!.id;
    if(currentUser.club!.id==null){
      createdFullLicence!.arbitrator!.club = selectedClub!.id;
    }
    else{
      createdFullLicence!.arbitrator!.club = currentUser.club!.id;
    }
    // createdFullLicence!.profile!.country=address;
    // createdFullLicence!.licence!.discipline = selectedDiscipline!.id;
    // createdFullLicence!.licence!.weight = selectedWeight!.id;
    // createdFullLicence!.licence!.degree = selectedDegree!.id;

    createdFullLicence!.licence!.activated = false;
    createdFullLicence!.licence!.state = selectedState;
    createdFullLicence!.licence!.verified = false;
    createdFullLicence!.licence!.role = 1;
    Map<String, dynamic> mapdata = {};
    mapdata['licence'] = createdFullLicence!.licence!.toJson();
    mapdata['user'] = createdFullLicence!.user!.toJson();
    mapdata['arbitre'] = createdFullLicence!.arbitrator!.toJson();
    mapdata['profile'] = createdFullLicence!.profile!.toJson();
    // print(mapdata);
    log(
      mapdata.toString(),
      name: mapdata.toString(),
      error: mapdata,
    );
    try {
      Response res = await licenceNetwork.addFullLicence(mapdata);
      if (res.statusCode == 200) {
        print('ok');
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
        print('not ok');
        print(res.statusMessage);
        final snackBar = MySnackBar(
          title: 'Echec',
          msg:
              'Il y a une probleme avec cet licence merci d verifier vos donnees',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
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

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        state: ContentType.failure,
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      print(e);
    }

    // createdFullLicence!.licence!.=selectedDegree!.id;
  }

  createAthlete(context) {
    // String? categoryId;
    // dynamic? gradeId;
    // dynamic? idDegree;
    // int? discipline;
    // int? profile;
    // dynamic? weights;
    // String? club;
    // User user=User(isSuperuser: false,username:createdFullLicence!.profile!.phone.toString(), password: "12345");
    createdFullLicence!.athlete!.categoryId = selectedCategory!.id;
    createdFullLicence!.athlete!.gradeId = selectedGrade!.id;
    if(currentUser.club!.id==null){
      createdFullLicence!.athlete!.club = selectedClub!.id;
    }
    else{
      createdFullLicence!.athlete!.club = currentUser.club!.id;
    }
    
    // createdFullLicence!.profile!.country=address;
    createdFullLicence!.athlete!.discipline = selectedDiscipline!.id;
    createdFullLicence!.athlete!.weights = selectedWeight!.id;
    createdFullLicence!.athlete!.idDegree = selectedDegree!.id;
    createAthleteLicence(context);
    // createdFullLicence!.athlete!.profile=createdFullLicence!.profile;
    // createdFullLicence!.profile!.sexe=selectedSex;
    // createdFullLicence!.profile!.state=state;
    // createdFullLicence!.user=user;
    // createdFullLicence!.profile!.=address;
    // createdFullLicence!.profile!.user=user;
  }

  createCoach(context) {
    // String? categoryId;
    // dynamic? gradeId;
    // dynamic? idDegree;
    // int? discipline;
    // int? profile;
    // dynamic? weights;
    // String? club;
    // User user=User(isSuperuser: false,username:createdFullLicence!.profile!.phone.toString(), password: "12345");
    createdFullLicence!.coach!.categoryId = selectedCategory!.id;
    createdFullLicence!.coach!.grade = selectedGrade!.id;
    
    if(currentUser.club!.id==null){
      createdFullLicence!.coach!.club = selectedClub!.id;
    }
    else{
      createdFullLicence!.coach!.club = currentUser.club!.id;
    }
    // createdFullLicence!.profile!.country=address;
    createdFullLicence!.coach!.discipline = selectedDiscipline!.id;
    createdFullLicence!.coach!.weights = selectedWeight!.id;
    createdFullLicence!.coach!.degree = selectedDegree!.id;
    createCoachLicence(context);
    // createdFullLicence!.athlete!.profile=createdFullLicence!.profile;
    // createdFullLicence!.profile!.sexe=selectedSex;
    // createdFullLicence!.profile!.state=state;
    // createdFullLicence!.user=user;
    // createdFullLicence!.profile!.=address;
    // createdFullLicence!.profile!.user=user;
  }

  createCoachLicence(context) async {
    added = true;
    createdFullLicence!.licence!.categorie = selectedCategory!.id;
    createdFullLicence!.licence!.grade = selectedGrade!.id;
    if(currentUser.club!.id==null){
      createdFullLicence!.licence!.club = selectedClub!.id;
    }
    else{
      createdFullLicence!.licence!.club = currentUser.club!.id;
    }
    // createdFullLicence!.profile!.country=address;
    createdFullLicence!.licence!.discipline = selectedDiscipline!.id;
    createdFullLicence!.licence!.weight = selectedWeight!.id;
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
    // print(mapdata);
    log(
      mapdata.toString(),
      name: mapdata.toString(),
      error: mapdata,
    );
    try {
      Response res = await licenceNetwork.addFullLicence(mapdata);
      if (res.statusCode == 200) {
        print('ok');
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
        print('not ok');
        print(res.statusMessage);
        final snackBar = MySnackBar(
          title: 'Echec',
          msg:
              'Il y a une probleme avec cet licence merci d verifier vos donnees',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
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

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        state: ContentType.failure,
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      print(e);
    }

    // createdFullLicence!.licence!.=selectedDegree!.id;
  }

  createAthleteLicence(context) async {
    added = true;
    createdFullLicence!.licence!.categorie = selectedCategory!.id;
    createdFullLicence!.licence!.grade = selectedGrade!.id;

    if(currentUser.club!.id==null){
      createdFullLicence!.licence!.club = selectedClub!.id;
    }
    else{
      createdFullLicence!.licence!.club = currentUser.club!.id;
    }
    // createdFullLicence!.licence!.club = selectedClub!.id;
    // createdFullLicence!.profile!.country=address;
    createdFullLicence!.licence!.discipline = selectedDiscipline!.id;
    createdFullLicence!.licence!.weight = selectedWeight!.id;
    createdFullLicence!.licence!.degree = selectedDegree!.id;

    createdFullLicence!.licence!.activated = false;
    createdFullLicence!.licence!.state = selectedState;
    createdFullLicence!.licence!.verified = false;
    createdFullLicence!.licence!.role = 2;
    Map<String, dynamic> mapdata = {};
    mapdata['licence'] = createdFullLicence!.licence!.toJson();
    mapdata['user'] = createdFullLicence!.user!.toJson();
    mapdata['athlete'] = createdFullLicence!.athlete!.toJson();
    mapdata['profile'] = createdFullLicence!.profile!.toJson();
    // print(mapdata);
    log(
      mapdata.toString(),
      name: mapdata.toString(),
      error: mapdata,
    );
    try {
      Response res = await licenceNetwork.addFullLicence(mapdata);
      if (res.statusCode == 200) {
        print('ok');
        
        // for (Season s in parameters!.seasons!){
        //   if (s.id==res.data['licence']['seasons']){
        //     createdFullLicence!.licence!.seasons=s.seasons;
        //   }
        // }
        createdFullLicence!.licence!.role="Athlete";
        createdFullLicence!.licence!.categorie = selectedCategory!.categorieAge;
    createdFullLicence!.licence!.grade = selectedGrade!.grade;

    if(currentUser.club!.id==null){
      createdFullLicence!.licence!.club = selectedClub!.name;
    }
    else{
      createdFullLicence!.licence!.club = currentUser.club!.name;
    }
    // createdFullLicence!.licence!.club = selectedClub!.id;
    // createdFullLicence!.profile!.country=address;
        createdFullLicence!.licence!.state = res.data['licence']['state'];

    createdFullLicence!.licence!.discipline = selectedDiscipline!.name;
    createdFullLicence!.licence!.weight = selectedWeight!.masseEnKillograme;
    createdFullLicence!.licence!.degree = selectedDegree!.degree;


    createdFullLicence!.athlete!.categoryId = selectedCategory!.categorieAge;
    createdFullLicence!.athlete!.gradeId = selectedGrade!.grade;
    if(currentUser.club!.id==null){
      createdFullLicence!.athlete!.club = selectedClub!.name;
    }
    else{
      createdFullLicence!.athlete!.club = currentUser.club!.name;
    }
    
    // createdFullLicence!.profile!.country=address;
    createdFullLicence!.athlete!.discipline = selectedDiscipline!.name;
    createdFullLicence!.athlete!.weights = selectedWeight!.masseEnKillograme;
    createdFullLicence!.athlete!.idDegree = selectedDegree!.degree;
    print(res.data);
    createdFullLicence!.licence!.numLicences=res.data['licence']['num_licences'];
    fullLicences.add(createdFullLicence!);
    notify();
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
        print('not ok');
        print(res.statusMessage);
        final snackBar = MySnackBar(
          title: 'Echec',
          msg:
              'Il y a une probleme avec cet licence merci d verifier vos donnees',

          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
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

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        state: ContentType.failure,
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      print(e);
    }

    // createdFullLicence!.licence!.=selectedDegree!.id;
  }

  showSearchDialog(context, numControl) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SearchDialog(this, numControl, context);
        });
  }

  showFilterDialog(context) {
    selectedSeason = Season(seasons: "Saison", id: -1);

    selectedCategory = Category(categorieAge: "Categorie", id: -1);
    (currentUser.club!.id!=null)?selectedClub =currentUser.club:selectedClub = Club(name: "Club", id: -1);
    // selectedClub = Club(name: "Club", id: -1);
    selectedDegree = Degree(degree: "Degree", id: -1);
    selectedDiscipline = Discipline(name: "Discipline", id: -1);
    selectedGrade = Grade(grade: "Grade", id: -1);
    selectedWeight = Weight(masseEnKillograme: 0, id: -1);
    selectedSex = "Sexe";
    selectedStatus = "Etat";
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return FilterDialog(this,  context);
        });
  }

  findLicence(String numLicence, context) {
    bool ok = false;
    for (FullLicence licence in fullLicences) {
      if (licence.licence!.numLicences == numLicence) {
        // Navigator.pop(context);
        selectedFullLicence = licence;
        ok = true;
        GoRouter.of(context).push(Routes.LicenceScreen);
        // GoRouter.of(context).
        // Navigator.push(context,
        //     MaterialPageRoute(builder: ((context) => LicenceScreen())));
        break;
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
      // Navigator.pop(context);
    }
    numLicence = '';
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
    selectedFullLicence!.profile!.phone = int.parse(phone);

    Map<String, dynamic> mapData = selectedFullLicence!.profile!.toJson();
    print(mapData);
    Response res = await licenceNetwork.editProfile(
        mapData, selectedFullLicence!.profile!.id);
    if (res.statusCode == 200) {
      print('ok');
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
    if(currentUser.club!.id==null){
    selectedFullLicence!.licence!.club = selectedClub!.id;
    selectedFullLicence!.athlete!.club = selectedClub!.id;
    }
    else{
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
    selectedFullLicence!.licence!.role = "Athlete";
    selectedFullLicence!.licence!.seasons = s.seasons;
    Map<String, dynamic> athleteData = selectedFullLicence!.athlete!.toJson();
    Map<String, dynamic> mapData = {
      'licence': licenceData,
      'athlete': athleteData
    };
    Response res = await licenceNetwork.editAthleteLicence(mapData);
    if (res.statusCode == 200) {
      print('ok');
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
      print('ok');
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

  editAthleteImages(context) async {
    Map<String, dynamic> mapData = {
      "photo": createdFullLicence!.athlete!.photo,
      "identity_photo": createdFullLicence!.athlete!.identityPhoto,
      "medical_photo": createdFullLicence!.athlete!.medicalPhoto,
    };
    Response res = await licenceNetwork.editAthleteProfile(
        mapData, selectedFullLicence!.athlete!.id);
    if (res.statusCode == 200) {
      print('ok');
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

  renewLicecne(context) async {
    // createdFullLicence!.licence!.categorie=selectedCategory!.id;
    //     createdFullLicence!.licence!.grade=selectedGrade!.id;

    // createdFullLicence!.licence!.degree=selectedDegree!.id;

    // createdFullLicence!.licence!.discipline=selectedDiscipline!.id;

    // createdFullLicence!.licence!.club=selectedClub!.id;
    // createdFullLicence!.licence!.weight=selectedWeight!.id;

    Map<String, dynamic> mapData = {
      'degree': selectedDegree!.id,
      'grade': selectedGrade!.id,
      'discipline': selectedDiscipline!.id,
      'weight': selectedWeight!.id,
      'club': selectedClub!.id,
      'categorie': selectedCategory!.id,
    };
    print(mapData);
    try {
      Response res = await licenceNetwork.renewLicence(
          mapData, selectedFullLicence!.licence!.numLicences);
      if (res.statusCode == 200) {
        print('ok');
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

  filterLicences(context) {
    if ((selectedCategory!.id != -1) ||
        (selectedClub!.id != -1) ||
        (selectedDegree!.id != -1) ||
        (selectedDiscipline!.id != -1) ||
        (selectedGrade!.id != -1) ||
        (selectedWeight!.id != -1) ||
        (selectedSeason!.id != -1) ||
        (selectedSex != "Sexe") ||
        (selectedStatus != "Etat")) {
      Navigator.pop(context);
      GoRouter.of(context).push(Routes.FilteredLicencesScreen);
      // Navigator.push(context, MaterialPageRoute(builder: (context)=>FilteredLicencesScreen()));
      print(selectedCategory!.id);
      print(selectedClub!.id);
      print(selectedDegree!.id);
      print(selectedDiscipline!.id);
      print(selectedGrade!.id);
      print(selectedWeight!.id);
      filteredFullLicences.clear();
      // filteredFullLicences=fullLicences;
      fullLicences.forEach((element) {
        filteredFullLicences.add(element);
      });
      if (selectedCategory!.id != -1) {
        print('filtering category');
        int i = 0;
        while (i < filteredFullLicences.length) {
          if (filteredFullLicences[i].licence!.categorie !=
              selectedCategory!.categorieAge) {
            filteredFullLicences.remove(filteredFullLicences[i]);
          } else {
            i++;
          }
          notifyListeners();
        }
      }
      if (selectedClub!.id != -1) {
        print('filtering club');
        int i = 0;
        while (i < filteredFullLicences.length) {
          if (filteredFullLicences[i].licence!.club != selectedClub!.name) {
            filteredFullLicences.remove(filteredFullLicences[i]);
          } else {
            i++;
          }
          notifyListeners();
        }
      }
      if (selectedDegree!.id != -1) {
        print('filtering degree');
        int i = 0;
        while (i < filteredFullLicences.length) {
          if (filteredFullLicences[i].licence!.degree !=
              selectedDegree!.degree) {
            filteredFullLicences.remove(filteredFullLicences[i]);
          } else {
            i++;
          }
          notifyListeners();
        }
      }
      if (selectedDiscipline!.id != -1) {
        print('filtering discipline');
        int i = 0;
        while (i < filteredFullLicences.length) {
          if (filteredFullLicences[i].licence!.discipline !=
              selectedDiscipline!.name) {
            filteredFullLicences.remove(filteredFullLicences[i]);
          } else {
            i++;
          }
          notifyListeners();
        }
      }
      if (selectedGrade!.id != -1) {
        print('filtering grade');
        int i = 0;
        while (i < filteredFullLicences.length) {
          if (filteredFullLicences[i].licence!.grade != selectedGrade!.grade) {
            filteredFullLicences.remove(filteredFullLicences[i]);
          } else {
            i++;
          }
          notifyListeners();
        }
      }
      if (selectedWeight!.id != -1) {
        print('filtering weight');
        int i = 0;
        while (i < filteredFullLicences.length) {
          if (filteredFullLicences[i].licence!.weight != null) {
            if (filteredFullLicences[i].licence!.weight!.toString() !=
                selectedWeight!.masseEnKillograme.toString()) {
              filteredFullLicences.remove(filteredFullLicences[i]);
            } else {
              i++;
            }
          } else {
            i++;
          }
          notifyListeners();
        }
      }
      if (selectedSeason!.id != -1) {
        print('filtering seasons');
        int i = 0;
        while (i < filteredFullLicences.length) {
          if (filteredFullLicences[i].licence!.seasons !=
              selectedSeason!.seasons) {
            filteredFullLicences.remove(filteredFullLicences[i]);
          } else {
            i++;
          }
          notifyListeners();
        }
      }
      if (selectedSex != "Sexe") {
        print('filtering Sexe');
        int i = 0;
        while (i < filteredFullLicences.length) {
          if (filteredFullLicences[i].profile!.sexe != selectedSex) {
            filteredFullLicences.remove(filteredFullLicences[i]);
          } else {
            i++;
          }
          notifyListeners();
        }
      }
      if (selectedStatus != "Etat") {
        print('filtering Status');
        int i = 0;
        while (i < filteredFullLicences.length) {
          print(filteredFullLicences[i].licence!.state!);
          if (filteredFullLicences[i].licence!.state != selectedStatus) {
            print('deleted');
            filteredFullLicences.remove(filteredFullLicences[i]);
          } else {
            i++;
          }
          notifyListeners();
        }
      }
    } else {
      Navigator.pop(context);
      final snackBar = MySnackBar(
          title: "Pas de filtrage",
          msg: "Merci d'appliquer un filtre",
          state: ContentType.warning);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
