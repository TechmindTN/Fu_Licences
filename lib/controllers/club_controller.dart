import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/network/club_network.dart';

import '../models/club.dart';
import '../models/user.dart';
import '../widgets/global/snackbars.dart';
import 'licence_controller.dart';

class ClubProvider extends ChangeNotifier{
  ClubNetwork clubNetwork=ClubNetwork();

  createClubProfile(
    LicenceProvider licenceController,
      {String? address,
      String? cin,
      String? firstName,
      String? lastName,
      String? phone,
      String? state}) {
        
    licenceController.createdFullLicence!.profile!.address = address;
    //licenceController.createdFullLicence!.profile!.birthday = licenceController.selectedBirth.toString();
    licenceController.createdFullLicence!.profile!.cin = cin;
    // createdFullLicence!.profile!.country=address;
    licenceController.createdFullLicence!.profile!.firstName = firstName;
    licenceController.createdFullLicence!.profile!.lastName = lastName;
    licenceController.createdFullLicence!.profile!.phone = int.parse(phone!);
    licenceController.createdFullLicence!.profile!.role = 7;
    licenceController.createdFullLicence!.profile!.sexe = licenceController.selectedSex;
    licenceController.createdFullLicence!.profile!.state = licenceController.selectedState;
    User user = User(
        isSuperuser: false,
        username: licenceController.createdFullLicence!.profile!.phone.toString(),
        password: "12345");
    licenceController.createdFullLicence!.user = user;
    // createdFullLicence!.profile!.=address;
    // createdFullLicence!.profile!.user=user;
  }
  createClub(context,LicenceProvider licenceController,name) async {
    try {
      Club club=Club(name: name,ligue: licenceController.selectedLigue!.id);
       Map<String, dynamic> mapdata = {};
    mapdata['user'] = licenceController.createdFullLicence!.user!.toJson();
    mapdata['club'] = club.toJson();
    mapdata['profile'] = licenceController.createdFullLicence!.profile!.toJson();
      Response res = await clubNetwork.addClub(mapdata);
      if (res.statusCode == 200) {
        print('club created successfully');
        print('ok');
        
        // for (Season s in parameters!.seasons!){
        //   if (s.id==res.data['licence']['seasons']){
        //     createdFullLicence!.licence!.seasons=s.seasons;
        //   }
        // }
       

    
    // createdFullLicence!.licence!.club = selectedClub!.id;
    // createdFullLicence!.profile!.country=address;
       
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
       print(e);
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
      
    }

  }

  notify(){
    notifyListeners();
  }
}