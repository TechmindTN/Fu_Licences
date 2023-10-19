import 'package:fu_licences/models/arbitrator.dart';
import 'package:fu_licences/models/coach.dart';
import 'package:fu_licences/models/profile.dart';
import 'package:fu_licences/models/user.dart';
import 'athlete.dart';
import 'licence.dart';

class FullLicence{
  User? user;
  Profile? profile;
  Licence? licence;
  Athlete? athlete;
  Arbitrator? arbitrator;
  Coach? coach;

  FullLicence({
    this.profile,
    this.arbitrator,
    this.athlete,
    this.coach,
    this.licence,
    this.user
  });


}