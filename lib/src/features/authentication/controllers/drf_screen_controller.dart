import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../profile/repository/user_repo.dart';
import '../models/users_model.dart';
import '../repository/authentication_repository/auth_repo.dart';

class DrfScreenController extends GetxController {
  final Map<String, TextEditingController> textEditingController = {};
  final UserRepo userRepo = Get.put(UserRepo());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController createTextController(key){
    final textEdit =  TextEditingController();
    textEditingController.putIfAbsent(key, () => textEdit);
    return textEdit;
  }


  @override
  void onInit() {
    super.onInit();
    // Initialize text editing controllers for each attribute
    for (var entry in professionAttributes) {
      textEditingController[entry['Title']!] = TextEditingController();
    }
  }

  void updateAttribute(String key, String value) {
    // Update attribute in the map
    // You might need to handle if the key doesn't exist
    // Or use a different approach if the attribute list is dynamic
    print('keykey = $key  value $value');


    textEditingController[key]?.text = value;
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required String profilePictureUrl,
    required String username,
    required String phoneNumber,
    required String governorate,
    required String profession,
  }) async {
    // Extract attributes for the selected profession
    // Map<String, String> professionAttributesMap = {};
    // for (var entry in professionAttributes) {
    //   if (entry['Title'] == profession) {
    //     professionAttributesMap = entry;
    //     break;
    //   }
    // }
    //
    // Map<String, String> temp = {};
    //
    // print(textEditingController.keys);
    // print('textEditingController');
    // professionAttributesMap.forEach((key, value) {
    //   print(key + ' keykey '+value);
    //   temp.putIfAbsent(key, () => textEditingController[key]?.text??'');
    // });
    //
    //
    // print(temp);
    // print('tttttttttttt');


    try {
      print('Registering user...');

      // Create user in Firebase authentication
      String? userId = await AuthRepo.instance.createUserWithEmailAndPassword(
          email, password);

      if (userId != null) {
        print('User created with ID: $userId');

        // Extract attributes for the selected profession
        Map<String, String> professionAttributesMap = {};
        for (var entry in professionAttributes) {
          if (entry['Title'] == profession) {
            professionAttributesMap = entry;
            break;
          }
        }


        Map<String, String> temp = {};

        print(textEditingController.keys);
        print('textEditingController');
        professionAttributesMap.forEach((key, value) {
          print(key + ' keykey '+value);
          temp.putIfAbsent(key, () => textEditingController[key]?.text??'');
        });


        print(temp);
        print('tttttttttttt');





        // Construct user object
        UserModel user = UserModel(
          id: userId,
          email: email,
          fullname: username,
          phoneNo: phoneNumber,
          governorate: governorate,
          profession: profession,
          about: '',
          // You can set default values as needed
          profilePictureUrl: profilePictureUrl,
          professionAttributes: temp, // Use the extracted attributes map
        );

        // Save user data to Firestore
        await userRepo.createUser(user);
        print('User registered successfully!');
      } else {
        print('Failed to create user');
        // Handle failure to create user
      }
    } catch (e) {
      print('Error registering user: $e');
      // Handle registration error
    }
  }

 /* Map<String, String> getProfessionAttributes(){
    return {
      "Title": "1st AD (Assistant Director)",
      "Skills": "Attribute value",
      "Availability Schedule": "Attribute value",
      "Experience": "Attribute value",
      "Preferred Work Genres": "Attribute value",
      "Qualifications": "Attribute value",
      "Work Genres": "Attribute value",
      "Director collaborations": "Attribute value",
      "Production Credits": "Attribute value",
      "Salary": "Attribute value"
    };
  }*/

  Map<String, int> professionsId = {
    "1st AD (Assistant Director)": 0,
    "2nd AC (Assistant Camera)": 1,
    "Actor": 2,
    "ADR (Automated Dialogue Replacement) Mixer": 3,
    "Art Director": 4,
    "Armorer": 5,
    "Assistant Costume Designer": 6,
    "Assistant Editor": 7,
    "Assistant Makeup Artist": 8,
    "Assistant Production Accountant": 9,
    "Assistant Production Coordinator": 10,
    "Assistant Prop Master": 11,
    "Associate Producer": 12,
    "Boom Operator": 13,
    "Camera Operator": 14,
    "Casting Assistant": 15,
    "Casting Associate": 16,
    "Casting Director": 17,
    "Choreographer": 18,
    "Cinematographer": 19,
    "Co-producer": 20,
    "Colorist": 21,
    "Company Producer": 22,
    "Composer": 23,
    "Costume Designer": 24,
    "Digital Imaging Technician": 25,
    "Director": 26,
    "Director of Photography": 27,
    "Dolly Grip": 28,
    "Drone Operator and Drone Pilot": 29,
    "Entertainment Lawyer": 30,
    "Extra": 31,
    "Festival Programmer": 32,
    "Field Recording Mixer": 33,
    "Film Editor": 34,
    "Film Electrician (Rigging and On-set Electrics)": 35,
    "First AC": 36,
    "Foley Artist and Foley Engineer": 37,
    "Gaffer or Best Boy": 38,
    "Graphic Artist": 39,
    "Grip and Key Grip": 40,
    "Hairdresser and Key Hair Stylist": 41,
    "Key PA (Production Assistant)": 42,
    "Line Producer or UPM (Unit Production Manager)": 43,
    "Location Manager": 44,
    "Location Scout": 45,
    "Makeup Artist": 46,
    "Manager": 47,
    "Music Supervisor": 48,
    "On Set VFX Supervisor or Visual Effects Supervisor": 49,
    "Post Supervisor": 50,
    "Post-Production Coordinator or Production Coordinator": 51,
    "Producer or Executive Producer": 52,
    "Production Accountant": 53,
    "Production Designer and (Set Decorator or Set Dresser)": 54,
    "Props Manager": 55,
    "Re-Recording Mixer": 56,
    "Screenwriter": 57,
    "Script Analyst or Script Reader": 58,
    "Script Supervisor": 59,
    "Showrunner or TV Producer": 60,
    "Sound Designer": 61,
    "Storyboard Artist": 62,
    "Stunt Coordinator": 63
  };

  List<Map<String, String>> professionAttributes = [
    {
      "Title": "1st AD (Assistant Director)",
      "Skills": "Attribute value",
      "Availability Schedule": "Attribute value",
      "Experience": "Attribute value",
      "Preferred Work Geners": "Attribute value",
      "Qualifications": "Attribute value",
      "Work Geners": "Attribute value",
      "Director collaborations": "Attribute value",
      "Production Credits": "Attribute value",
      "Salary": "Attribute value"

    },
    {
      "Title": "2nd AC (Assistant Camera)",
      "Filming Experience": "Attribute value",
      "Camera knowledge": "Attribute value",
      "Lens Knowledge": "Attribute value",
      "DIT Collaboration": "Attribute value",
      "Qualifications": "Attribute value",
      "Organizing skills": "Attribute value",
      "On-set Problem-solving": "Attribute value",
      "Salary": "Attribute value",
    },
    {
      "Title": "Actor",
      "Height (In CM)": "Attribute value",
      "Weight": "Attribute value",
      "Eye color": "Attribute value",
      "Hair Color": "Attribute value",
      "Special Skills": "Attribute value",
      "Languages (seperate by commas)": "Attribute value",
      "Availablity": "Attribute value",
      "Age": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "ADR (Automated dialouge replacement) Mixer ",
      "Experience": "Attribute value",
      "Projects": "Attribute value",
      "Collaborations": "Attribute value",
      "Equipment Knowledge": "Attribute value",
      "Pro Tools Proficiency": "Attribute value",
      "Availablity": "Attribute value",
      "Preferred Working Hours": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Art Director ",
      "Design Software Proficiency": "Attribute value",
      "Adaptability and Flexibility": "Attribute value",
      "Industry Focus": "Attribute value",
      "Project Management": "Attribute value",
      "Availablity": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Armorer",
      "Years of Experience": "Attribute value",
      "Weapons Expertise": "Attribute value",
      "Types of Weapons": "Attribute value",
      "Safety Protocols": "Attribute value",
      "Emergency Procedures": "Attribute value",
      "Licensing Information": "Attribute value",
      "Collaboration Skills": "Attribute value",
      "Equipment Management": "Attribute value",
      "Insurance and Liability": "Attribute value",
      "Availability": "Attribute value",
      "Emergency Contact": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Assistant Costume Designer",
      "Years of Experience": "Attribute value",
      "Costume Design Skills": "Attribute value",
      "Fabric Knowledge": "Attribute value",
      "Communication with Actors": "Attribute value",
      "Organizational Skills": "Attribute value",
      "Availability": "Attribute value",
      "Preferred Project Types": "Attribute value",
      "Use of Technology in Design": "Attribute value",
      "Gender and Age Considerations": "Attribute value",
      "Budget Range": "Attribute value"
    },
    {
      "Title": "Assistant Editor",
      "Experience/Qualifications": "Attribute value",
      "Software Skills": "Attribute value",
      "Education Background": "Attribute value",
      "Certifications": "Attribute value",
      "Work Hours": "Attribute value",
      "Organizational Skills": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Assistant Makeup Artist",
      "Products and Brands": "Attribute value",
      "Experience Level": "Attribute value",
      "Availability for Events": "Attribute value",
      "Preferred Makeup Styles": "Attribute value",
      "Skills Keywords": "Attribute value",
      "Certifications": "Attribute value",
      "Social Media Profiles": "Attribute value",
      "Budget Range": "Attribute value"
    },
    {
      "Title": "Assistant Production Accountant",
      "1st and 2nd Assistant availabiltiy": "Attribute value",
      "Computer accounting system knowledge": "Attribute value",
      "Salary": "Attribute value",
      "Cost Reporting Formats": "Attribute value",
      "Management Skills": "Attribute value",
      "Continuous Learning": "Attribute value",
      "Logical Thinking": "Attribute value"
    },
    {
      "Title": "Assistant Production Coordinator",
      "Production Coordinator Availabilty": "Attribute value",
      "Production manual guidelines and protocols Knowledge": "Attribute value",
      "Computer skills": "Attribute value",
      "Experience": "Attribute value",
      "Organization skills": "Attribute value",
      "Call Sheet Management": "Attribute value",
      "Crew Coordination Skills": "Attribute value",
      "Emergency Response Preparedness": "Attribute value",
      "Availability": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Assistant Prop Master",
      "Prop Department Equipment mangement": "Attribute value",
      "Improvisation Skills": "Attribute value",
      "Prop Master Assistants ": "Attribute value",
      "Problem-solving experience": "Attribute value",
      "Materials Sourcing Knowledge": "Attribute value",
      "Communication Skills": "Attribute value",
      "Materials Expertise": "Attribute value",
      "Salary": "Attribute value",
      "Availability": "Attribute value"
    },
    {
      "Title": "Associate Producer",
      "On-set experiences": "Attribute value",
      "Project Development Experience": "Attribute value",
      "Production Genres": "Attribute value",
      "Budgeting and Finance Skills": "Attribute value",
      "Management Skills": "Attribute value",
      "Content Distribution Knowledge": "Attribute value",
      "Script Analysis": "Attribute value",
      "Availability": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Boom Operator",
      "Wireless Microphone Systems Proficiency": "Attribute value",
      "Recording Equipment Skills": "Attribute value",
      "Knowledge of Sound Equipment": "Attribute value",
      "Location Experience": "Attribute value",
      "Experience with sound while shooting videos": "Attribute value",
      "On-set experience": "Attribute value",
      "Microphone Placement Techniques": "Attribute value",
      "Troubleshooting skills": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Camera Operator",
      "1st and 2nd AC assistants collaboration": "Attribute value",
      "Camera Department Experience": "Attribute value",
      "Camera Equipment Knowledge": "Attribute value",
      "Filmmaking Experience": "Attribute value",
      "Communication Skills": "Attribute value",
      "Problem-solving Skills": "Attribute value",
      "Availability": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Casting Assistant",
      "Talent Database Management": "Attribute value",
      "Casting Call Organization": "Attribute value",
      "Character Analysis": "Attribute value",
      "Communication Skills": "Attribute value",
      "Event Planning": "Attribute value",
      "Availability": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Casting Associate",
      "Communication and Interaction Skills": "Attribute value",
      "Filmmaking Experience ": "Attribute value",
      "Experience Level": "Attribute value",
      "Organization Skills": "Attribute value",
      "Computer and Editing Software Knowledge": "Attribute value",
      "Character Analysis": "Attribute value",
      "Availability": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Casting Director",
      "Analyzation Skills": "Attribute value",
      "Remote Casting Experience": "Attribute value",
      "Project Management Skills": "Attribute value",
      "Knowledge of Actors": "Attribute value",
      "Organization Skills": "Attribute value",
      "Communication Skills": "Attribute value",
      "Character Analysis": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Choreographer",
      "Troubleshoot Skill": "Attribute value",
      "Choreographic Process": "Attribute value",
      "Teaching Experience": "Attribute value",
      "Dance Styles": "Attribute value",
      "Communication Skills": "Attribute value",
      "Years of Experience": "Attribute value",
      "Project Types": "Attribute value",
      "Budget Range": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Cinematographer",
      "Cinematographic Techniques": "Attribute value",
      "Years of Experience": "Attribute value",
      "Camera Equipment Knowledge": "Attribute value",
      "Photographic Skills": "Attribute value",
      "Lighting Equipment Knowledge": "Attribute value",
      "Filmmaking Experience ": "Attribute value",
      "Strong communication skills": "Attribute value",
      "Strong team management skills": "Attribute value",
      "Collaboration Skills": "Attribute value",
      "Problem-solving Skills": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Co-producer",
      "Filmmaking Experience ": "Attribute value",
      "Real-world experience": "Attribute value",
      "Communication and Interaction Skills ": "Attribute value",
      "Multi-tasking Skills": "Attribute value",
      "Basic Computer Knowledge": "Attribute value",
      "Availability": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Colorist",
      "Color Correction Skills": "Attribute value",
      "Computer Skills": "Attribute value",
      "Multi-tasking Skills": "Attribute value",
      "Technical and Creative Process Knowledge": "Attribute value",
      "Match Grading Experience": "Attribute value",
      "Specialization": "Attribute value",
      " Artistic and Technical Skills": "Attribute value",
      "Filmmaking Process Background": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Company Producer",
      "Editing and Visual Effects Skills": "Attribute value",
      "Color Correction Skills": "Attribute value",
      "Business Experience ": "Attribute value",
      "Specialization": "Attribute value",
      "Project Management Experience": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Composer",
      "Computer and Technology Experience": "Attribute value",
      "Musical Requirements Knowledge": "Attribute value",
      "Mixing and Digital editing Experience": "Attribute value",
      "Budgeting and Orchestration Skills": "Attribute value",
      "Instruments Usage Skills": "Attribute value",
      "Music Expert": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Costume Designer",
      "Costume Construction Skills ": "Attribute value",
      "Sewing Skills": "Attribute value",
      "Materials Expertise": "Attribute value",
      "Wardrobe Management": "Attribute value",
      "Light and Color Skills": "Attribute value",
      "Character Analysis": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Digital Imaging Technician",
      "Organizational Skills": "Attribute value",
      "Computer Hard Drives Knowledge": "Attribute value",
      "Video Editing Knowledge": "Attribute value",
      "Software Proficiency": "Attribute value",
      "File Formats Experience": "Attribute value",
      "Color Management": "Attribute value",
      "LUTs(Look Up Tables) Skills": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Director",
      "Screenwriting  Skills": "Attribute value",
      "Cinematography Skills": "Attribute value",
      "Production design": "Attribute value",
      "Sound and Editing Skills": "Attribute value",
      "Lenses and Cameras Knowledge ": "Attribute value",
      "Communication Skills": "Attribute value",
      "Departments Knowledge": "Attribute value",
      "Collaboration Skills ": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Director of Photography",
      "Camera Expertise": "Attribute value",
      "Camera and Lense Equipment Knowledge": "Attribute value",
      "Drone Operating": "Attribute value",
      "Light Experience": "Attribute value",
      "DIT Skills": "Attribute value",
      "Color Grading Expertise": "Attribute value",
      "Photography Skills ": "Attribute value",
      "Visual Communication and Collaboratio Skills": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Dolly Grip",
      "Camera Support Experience": "Attribute value",
      "Animation of Camera ": "Attribute value",
      "Technical Skills": "Attribute value",
      "Dolly Rigging Skills": "Attribute value",
      "Knowledge of Camera Movement Techniques": "Attribute value",
      "Coordination with Camera Operator": "Attribute value",
      "Experience with Different Dolly Accessories": "Attribute value",
      "Experience with Remote Dolly Operation": "Attribute value",
      "Lens Selection Collaboration": "Attribute value",
      "Dolly Types Knowledge": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Drone Operator and Drone Pilot",
      "Drone Technology System Knowledge": "Attribute value",
      "Drone Operation License": "Attribute value",
      "Qualifications": "Attribute value",
      "Availabilty for Travel": "Attribute value",
      "Battery and Flight Planning": "Attribute value",
      "Remote Operation Experience": "Attribute value",
      "Camera and Equipment Proficiency ": "Attribute value",
      "Sound Mixing Skills": "Attribute value",
      "DIT Skills": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Entertainment Lawyer",
      "Negotiation Experience ": "Attribute value",
      "Client Communication": "Attribute value",
      "Data Privacy and Security Compliance": "Attribute value",
      "Event Contracting": "Attribute value",
      "Filmmaking Laws": "Attribute value",
      "Legal Knowledge": "Attribute value",
      "Professional Certifications ": "Attribute value",
      "Licensing  Agreements Experience": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Extra",
      "Height": "Attribute value",
      "Weight": "Attribute value",
      "Eye color": "Attribute value",
      "Hair Color": "Attribute value",
      "Special Skills": "Attribute value",
      "Languages they speak": "Attribute value",
      "Availablity": "Attribute value",
      "Age": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Festival Programmer",
      " Filmmaking Experience": "Attribute value",
      "International Film Experience": "Attribute value",
      "Festival Selection Criteria": "Attribute value",
      "Festival Film Selections": "Attribute value",
      "Film Festival Awards Won": "Attribute value",
      "Communication Skills": "Attribute value",
      "Event Planning Experience": "Attribute value",
      "Feedback Collection and Analysis": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Field Recording Mixer",
      "Sound Expertise": "Attribute value",
      "Sound Recording Equipment Knowledge": "Attribute value",
      "Acoustics Knowledge": "Attribute value",
      "Filming Experience": "Attribute value",
      "Safety Protocols": "Attribute value",
      "Remote Recording Experience": "Attribute value",
      "Field Recording Techniques": "Attribute value",
      "Wireless Audio Systems Knowledge": "Attribute value",
      "Sound Editing Skills": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Film Editor",
      "Specialization": "Attribute value",
      "Filmmaking Experience": "Attribute value",
      "Editing Software Proficiency": "Attribute value",
      "Editing Experience": "Attribute value",
      "Special Effects and CGI Knowledge": "Attribute value",
      "Color Grading Skills": "Attribute value",
      "Sound Editing and Mixing Skills": "Attribute value",
      "Years of Editing Experience": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Film Electrician (Rigging and On-set Electrics)",
      "Technical Certifications": "Attribute value",
      "Interpersonal Skills": "Attribute value",
      "Specialization in Lighting Design": "Attribute value",
      "Rigging and Set-Up Skills": "Attribute value",
      "Safety Protocols Adherence": "Attribute value",
      "Electrical Codes Knowledge": "Attribute value",
      "Problem-Solving Skills": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "First AC",
      "Camera Setup and Operating Experience": "Attribute value",
      "Technical Equipment Experience": "Attribute value",
      "Camera Systems Experience": "Attribute value",
      "Planning Skills": "Attribute value",
      "Lens Knowledge": "Attribute value",
      "Focus Pulling Skills": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Foley Artist and Foley Engineer",
      "Custom-Made Sound Effects Experience": "Attribute value",
      "Foley Studio Setup": "Attribute value",
      "Sound and Movement Expertise": "Attribute value",
      "Acoustics Knowledge": "Attribute value",
      "Foley Techniques": "Attribute value",
      "Microphone and Recording Experience": "Attribute value",
      "Props and Surfaces Use": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Gaffer or Best Boy",
      "Light Setting Experience": "Attribute value",
      "Types of Productions Worked On": "Attribute value",
      "Management of Lighting Crew": "Attribute value",
      "Use of Various Lighting Equipment": "Attribute value",
      "Electrical Safety Protocols Adherence": "Attribute value",
      "Rigging and Set-Up Skills": "Attribute value",
      "Knowledge of Power Distribution": "Attribute value",
      "Problem-Solving Skills": "Attribute value",
      "Knowledge of Lighting Control Systems": "Attribute value",
      "Professional Title": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Graphic Artist",
      "Years of Experience": "Attribute value",
      "Specialization": "Attribute value",
      "Typography and Drawing Skills": "Attribute value",
      "Visual Effects and Cinematic Transitions Experience": "Attribute value",
      "Software Programs Experience": "Attribute value",
      "Animation Skills": "Attribute value",
      "Photography Skills": "Attribute value",
      "UI Design Skills": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Grip and Key Grip",
      "Camera Movement Knowledge": "Attribute value",
      "Lighting Techniques": "Attribute value",
      "Electrical Requirements Knowledge": "Attribute value",
      "Rigging and Set-Up Skills": "Attribute value",
      "Grip Equipment Use and Knowledge": "Attribute value",
      "Freelance or Production Company Affiliation": "Attribute value",
      "Safety Protocols Adherence": "Attribute value",
      "Professional Title": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Hairdresser and Key Hair Stylist",
      "Photography Skills": "Attribute value",
      "Portfolio or Work Samples": "Attribute value",
      "Freelance or Production Company Affiliation": "Attribute value",
      "Expertise in Hairstyling": "Attribute value",
      "Types of Productions Worked On": "Attribute value",
      "Character Analysis": "Attribute value",
      "Wigs and Hairpieces Proficiency": "Attribute value",
      "Hair Care Products Knowledge": "Attribute value",
      "Costume and Wardrobe Knowledge": "Attribute value",
      "Professional Title": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Key PA (Production Assistant)",
      "Problem-Solving Skills": "Attribute value",
      "Office and Communication Skills": "Attribute value",
      "Tasks Management Skills": "Attribute value",
      "Call Sheet Experience": "Attribute value",
      "Craft Services": "Attribute value",
      "Management of Walkie-Talkie Communication": "Attribute value",
      "Assistance with Equipment Moves": "Attribute value",
      "Release Forms and Permits Management Experience": "Attribute value",
      "Departments Collaboration": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Line Producer or UPM (Unit Production Manager)",
      "Budget Management and Scheduling Skills": "Attribute value",
      "Coordination Skills": "Attribute value",
      "Qualifications": "Attribute value",
      "Availability": "Attribute value",
      "Organization Skills": "Attribute value",
      "Years of experience": "Attribute value",
      "Professional Title": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Location Manager",
      "Photography Skills": "Attribute value",
      "Location Management Skills": "Attribute value",
      "Problem-solving Skills": "Attribute value",
      "Filmmaking Knowledge": "Attribute value",
      "Coordination Skills": "Attribute value",
      "Availability": "Attribute value",
      "Equipment Knowledge": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Location Scout",
      "Expertise in Location Scouting": "Attribute value",
      "Years of Experience": "Attribute value",
      "Photographic Documentation": "Attribute value",
      "Geographical Information Systems (GIS) Skills": "Attribute value",
      "Location Cataloging System": "Attribute value",
      "Digital Location Libraries": "Attribute value",
      "Knowledge of Location Restrictions": "Attribute value",
      "Location Reports Experience": "Attribute value",
      "Negotiation Skills": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Makeup Artist",
      "Portfolio and References": "Attribute value",
      "Freelance or Production Company Affiliation": "Attribute value",
      "Expertise in Makeup Styles": "Attribute value",
      "Use of Makeup Products and Brands": "Attribute value",
      "Knowledge of Skin Types and Tones": "Attribute value",
      "Makeup Hygiene and Safety Adherence": "Attribute value",
      "Management of Makeup Budgets": "Attribute value",
      "Experience with Green Screen Makeup": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Manager",
      "Marketing Expertise": "Attribute value",
      "Department or Division": "Attribute value",
      "Skills and Expertise": "Attribute value",
      "Qualifications": "Attribute value",
      "Professional Certifications": "Attribute value",
      "Performance Metrics (KPIs)": "Attribute value",
      "Educational Background": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Music Supervisor",
      "Music Composer Collaboration": "Attribute value",
      "Music Editing Skills": "Attribute value",
      "Expertise in Music Genres": "Attribute value",
      "Music Licensing and Clearance Processes Experience": "Attribute value",
      "Software Proficiency": "Attribute value",
      "Types of Productions Worked On": "Attribute value",
      "Project Themes Interpreting": "Attribute value",
      "Years of Experience": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "On Set VFX Supervisor or Visual Effects Supervisor",
      "VFX Budget Management": "Attribute value",
      "Multitasking Skills": "Attribute value",
      "VFX Software and Tools Proficiency": "Attribute value",
      "Design and Animation Experience": "Attribute value",
      "Editing Software Experience": "Attribute value",
      "Photoshoping Skills": "Attribute value",
      "Green Screen Expertise": "Attribute value",
      "VR or AR Experience": "Attribute value",
      "3D Modeling and Animation Proficiency": "Attribute value",
      "Professional Title": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Post Supervisor",
      "Post-Production Project Management": "Attribute value",
      "Color Correction and Visual Effects Knowledge": "Attribute value",
      "Quality Control Experience": "Attribute value",
      "Budget Management": "Attribute value",
      "Editing Knowledge": "Attribute value",
      "Sound Design Knowledge": "Attribute value",
      "Post-Production Software Proficiency": "Attribute value",
      "Productions Worked On": "Attribute value",
      "Computer Skills": "Attribute value",
      "Sharing Platforms Knowledge": "Attribute value"
    },
    {
      "Title": "Post-Production Coordinator or Production Coordinator",
      "Specialization": "Attribute value",
      "Organizational Skills": "Attribute value",
      "Production Experience": "Attribute value",
      "Post-Production Schedules Management Experience": "Attribute value",
      "Post-Production Budgeting Experience": "Attribute value",
      "Dubbing and Sound Design Assistance": "Attribute value",
      "Quality Control and Digital Intermediate (DI) Assistance": "Attribute value",
      "Experience in Subtitling and Captioning": "Attribute value",
      "Oral and Written Communication Skills": "Attribute value",
      "Computer Skills": "Attribute value",
      "General Filmmaking Knowledge": "Attribute value",
      "Professional Title": "Attribute value"
    },
    {
      "Title": "Producer or Executive Producer",
      "Production Experience": "Attribute value",
      "Self-Employed or Production Company": "Attribute value",
      "Years of Experience": "Attribute value",
      "Financial Expertise": "Attribute value",
      "Pre-Production and Post-Production Management": "Attribute value",
      "Location Scouting Experience": "Attribute value",
      "Film Production Technology Proficiency": "Attribute value",
      "Genres Specialized In": "Attribute value",
      "Production Management Tools": "Attribute value",
      "Basic Skills": "Attribute value",
      "Professional Title": "Attribute value"
    },
    {
      "Title": "Production Accountant",
      "Bookkeeping and Accounting Experience": "Attribute value",
      "Financial Expertise": "Attribute value",
      "Financial Reporting Experience": "Attribute value",
      "Budget Management Experience": "Attribute value",
      "Financial Compliance Assurance": "Attribute value",
      "Production Insurance Knowledge": "Attribute value",
      "Negotiation Skills": "Attribute value",
      "Accounting Software Proficiency": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Production Designer and (Set Decorator or Set Dresser)",
      "Art Department Management": "Attribute value",
      "Lighting and Color Theory Knowledge": "Attribute value",
      "Prop Design and Set Dressing Experience": "Attribute value",
      "Visual Style Specialization": "Attribute value",
      "Artistic Influences Knowledge": "Attribute value",
      "Portfolio of Previous Work": "Attribute value",
      "Communication Skills": "Attribute value",
      "Knowledge of Lighting Effects": "Attribute value",
      "Expertise in Specific Periods": "Attribute value",
      "Technical Skills": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Props Manager",
      "Specialization": "Attribute value",
      "Organization Skills": "Attribute value",
      "Computer Skills": "Attribute value",
      "Collaborative Tools Experience": "Attribute value",
      "Customization and Modification Skills": "Attribute value",
      "Local and Global Prop Markets Knowledge": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Re-Recording Mixer",
      "Dialouge Editing Experience": "Attribute value",
      "Sound Recording Experience": "Attribute value",
      "Music Background": "Attribute value",
      "Sound Editing and Mixing Software Proficiency": "Attribute value",
      "Foley Libraries and Sound Effects Proficiency": "Attribute value",
      "Sound Effects Editing Experience": "Attribute value",
      "Audio Editing Tools Knowledge": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Screenwriter",
      "Genres Specialization": "Attribute value",
      "Dialogue Writing Skills": "Attribute value",
      "Script Development Process": "Attribute value",
      "Screenwriting Software Proficiency": "Attribute value",
      "Experimental Script Formats": "Attribute value",
      "Membership": "Attribute value",
      "Script Development Speed": "Attribute value",
      "Writing Style": "Attribute value",
      "Popular Scripts": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Script Analyst or Script Reader",
      "Types of Scripts Analyzed": "Attribute value",
      "Script Analysis Tools Proficiency": "Attribute value",
      "Professional Certifications": "Attribute value",
      "Feedback Presentation Style": "Attribute value",
      "Specialized Genres": "Attribute value",
      "Bilingual Script Analysis": "Attribute value",
      "Language Proficiency": "Attribute value",
      "Script Evaluation Experience": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Script Supervisor",
      "Camera Shots and Angles Knowledge": "Attribute value",
      "Lighting Setups Knowledge": "Attribute value",
      "Continuity Tracking Techniques": "Attribute value",
      "On-Set Communication Style": "Attribute value",
      "Management of Crowd Scenes": "Attribute value",
      "Organization Skills": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Showrunner or TV Producer",
      "Production Experience": "Attribute value",
      "Creation and Development of Show Concepts": "Attribute value",
      "Script Development and Approval": "Attribute value",
      "Storytelling Techniques": "Attribute value",
      "Showrunner's Approach to Character Development": "Attribute value",
      "Handling of Script Revisions": "Attribute value",
      "Genres of TV Productions Worked On": "Attribute value",
      "Budget Management": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Sound Designer",
      "Diegetic and Non-diegetic Sound Experience": "Attribute value",
      "Expertise in Audio Software": "Attribute value",
      "Technical Expertise": "Attribute value",
      "Sound Effects Creation and Library Management": "Attribute value",
      "Acoustics Knowledge": "Attribute value",
      "Mixing and Mastering Skills": "Attribute value",
      "Recording Experience": "Attribute value",
      "Audio Restoration and Enhancement": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Storyboard Artist",
      "Expertise in Visual Storytelling": "Attribute value",
      "Digital Animation Experience": "Attribute value",
      "Design and Animation Experience": "Attribute value",
      "Action Sequences and Special Effects Experience": "Attribute value",
      "Visual Style Specialization": "Attribute value",
      "Drawing Skills (Hand and Computer)": "Attribute value",
      "Software Proficiency": "Attribute value",
      "Salary": "Attribute value"
    },
    {
      "Title": "Stunt Coordinator",
      "Expertise in Specific Stunt Techniques": "Attribute value",
      "Safety Protocols Adherence": "Attribute value",
      "Stunt Equipment Proficiency": "Attribute value",
      "Language Proficiency": "Attribute value",
      "High-Risk Stunt Experience": "Attribute value",
      "Stunt Description (Age, Height, Weight, etc.)": "Attribute value",
      "Salary": "Attribute value"
    }
  ];
}
