import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:fu_licences/controllers/licence_controller.dart';
import 'package:fu_licences/models/category.dart';
import 'package:fu_licences/models/club.dart';
import 'package:fu_licences/models/degree.dart';
import 'package:fu_licences/models/discipline.dart';
import 'package:fu_licences/models/grade.dart';
import 'package:fu_licences/models/season.dart';
import 'package:fu_licences/models/weight.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Widget TextInput(String txt,TextEditingController control){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal:24.0,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(txt),
        Container(
          width: 50.w,
          height: 5.h,
          child: TextFormField(
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
            controller: control,
          ),
        )
      ],
    ),
  );
}


SelectInput(txt,selected,LicenceProvider licenceController,List<String>selectList){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal:24.0,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(txt),



        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black38)
          ),
          width: 25.w,
          height: 4.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownSearch<String>(
            
    popupProps: PopupProps.modalBottomSheet(
      showSearchBox: true,
      constraints: BoxConstraints(maxHeight: 30.h,
      minHeight: 10.h
      ),
        showSelectedItems: true,
        // disabledItemFn: (String s) => s.startsWith('I'),
    ),
    
    items: selectList,
    dropdownDecoratorProps: DropDownDecoratorProps(


        dropdownSearchDecoration: InputDecoration(
          filled: false,
              // labelText: selected,
              hintText: "Choisir votre "+txt,
              
        ),
    ),
    // onChanged: (value){
    //   selected=value;
    //   licenceController.notify();
    // },
    onChanged: (value){
      selected=value;
      if(txt=="Sexe"){
        licenceController.selectedSex=value!;
      }
      else if(txt=="Governorat"){
          licenceController.selectedState=value!;
        }
        else if(txt=="Etat"){
          licenceController.selectedStatus=value!;
        }
      
      print(selected);
      
    },
    selectedItem: selected,
),
          )
          // TextFormField(
          //   decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),
          //   controller: control,
          // ),
        )
      ],
    ),
  );
  
  
  
  


}


SeasonSelectInput(txt,selected,LicenceProvider licenceController){
 return Padding(
    padding: const EdgeInsets.symmetric(horizontal:24.0,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(txt),
       Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black38)
          ),
          width: 25.w,
          height: 4.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownSearch<Season>(   
              compareFn: (item1, item2) => item1.id==item2.id,       
    popupProps: PopupProps.modalBottomSheet(
      showSearchBox: true,
      constraints: BoxConstraints(maxHeight: 30.h,
      minHeight: 10.h
      ),
        showSelectedItems: true,
        // disabledItemFn: (String s) => s.startsWith('I'),
    ),
    itemAsString: (item) => item.seasons!,
    items: licenceController.parameters!.seasons!,
    dropdownDecoratorProps: DropDownDecoratorProps(
       dropdownSearchDecoration: InputDecoration(
          filled: false,
              // labelText: selected,
              hintText: "Choisir votre "+txt,
              
        ),
    ),
    // onChanged: (value){
    //   selected=value;
    //   licenceController.notify();
    // },
    onChanged: (value){
      selected=value;
      licenceController.selectedSeason=value;
      print(selected.id);
      
    },
    selectedItem: selected,
),
          )
        )
      ],
    ),
  );
}


GategorySelectInput(txt,selected,LicenceProvider licenceController){
 return Padding(
    padding: const EdgeInsets.symmetric(horizontal:24.0,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(txt),
       Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black38)
          ),
          width: 25.w,
          height: 4.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownSearch<Category>(   
              compareFn: (item1, item2) => item1.id==item2.id,       
    popupProps: PopupProps.modalBottomSheet(
      showSearchBox: true,
      constraints: BoxConstraints(maxHeight: 60.h,
      minHeight: 20.h
      ),
        showSelectedItems: true,
        // disabledItemFn: (String s) => s.startsWith('I'),
    ),
    itemAsString: (item) => item.categorieAge!,
    items: licenceController.parameters!.categories!,
    dropdownDecoratorProps: DropDownDecoratorProps(
       dropdownSearchDecoration: InputDecoration(
          filled: false,
              // labelText: selected,
              hintText: "Choisir votre "+txt,
              
        ),
    ),
    // onChanged: (value){
    //   selected=value;
    //   licenceController.notify();
    // },
    onChanged: (value){
      selected=value;
      licenceController.selectedCategory=value;
      print(selected.id);
      
    },
    selectedItem: selected,
),
          )
        )
      ],
    ),
  );
}

DegreeSelectInput(txt,selected,LicenceProvider licenceController){
 return Padding(
    padding: const EdgeInsets.symmetric(horizontal:24.0,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(txt),
       Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black38)
          ),
          width: 25.w,
          height: 4.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownSearch<Degree>(     
              compareFn: (item1, item2) => item1.id==item2.id,      
    popupProps: PopupProps.modalBottomSheet(
      showSearchBox: true,
      constraints: BoxConstraints(maxHeight: 30.h,
      minHeight: 10.h
      ),
        showSelectedItems: true,
        // disabledItemFn: (String s) => s.startsWith('I'),
    ),
    itemAsString: (item) => item.degree!,
    items: licenceController.parameters!.degrees!,
    dropdownDecoratorProps: DropDownDecoratorProps(
       dropdownSearchDecoration: InputDecoration(
          filled: false,
              // labelText: selected,
              hintText: "Choisir votre "+txt,
              
        ),
    ),
    // onChanged: (value){
    //   selected=value;
    //   licenceController.notify();
    // },
    onChanged: (value){
      selected=value;
      licenceController.selectedDegree=value;
      print(selected.id);
      
    },
    selectedItem: selected,
),
          )
        )
      ],
    ),
  );
}


WeightSelectInput(txt,selected,LicenceProvider licenceController){
 return Padding(
    padding: const EdgeInsets.symmetric(horizontal:24.0,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(txt),
       Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black38)
          ),
          width: 25.w,
          height: 4.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownSearch<Weight>(   
              compareFn: (item1, item2) => item1.id==item2.id,        
    popupProps: PopupProps.modalBottomSheet(
      showSearchBox: true,
      constraints: BoxConstraints(maxHeight: 30.h,
      minHeight: 10.h
      ),
        showSelectedItems: true,
        // disabledItemFn: (String s) => s.startsWith('I'),
    ),
    itemAsString: (item) => item.masseEnKillograme.toString(),
    items: licenceController.parameters!.weights!,
    dropdownDecoratorProps: DropDownDecoratorProps(
       dropdownSearchDecoration: InputDecoration(
          filled: false,
              // labelText: selected,
              hintText: "Choisir votre "+txt,
              
        ),
    ),
    // onChanged: (value){
    //   selected=value;
    //   licenceController.notify();
    // },
    onChanged: (value){
      selected=value;
      licenceController.selectedWeight=value;
      print(selected.id);
      
    },
    selectedItem: selected,
),
          )
        )
      ],
    ),
  );
}


ClubSelectInput(txt,selected,LicenceProvider licenceController){
 return Padding(
    padding: const EdgeInsets.symmetric(horizontal:24.0,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(txt),
       Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black38)
          ),
          width: 25.w,
          height: 4.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownSearch<Club>(    
              compareFn: (item1, item2) => item1.id==item2.id,       
    popupProps: PopupProps.modalBottomSheet(
      showSearchBox: true,
      constraints: BoxConstraints(maxHeight: 30.h,
      minHeight: 10.h
      ),
        showSelectedItems: true,
        // disabledItemFn: (String s) => s.startsWith('I'),
    ),
    itemAsString: (item) => item.name!,
    items: licenceController.parameters!.clubs!,
    dropdownDecoratorProps: DropDownDecoratorProps(
       dropdownSearchDecoration: InputDecoration(
          filled: false,
              // labelText: selected,
              hintText: "Choisir votre "+txt,
              
        ),
    ),
    // onChanged: (value){
    //   selected=value;
    //   licenceController.notify();
    // },
    onChanged: (value){
      selected=value;
      licenceController.selectedClub=value;
      print(selected.id);
      
    },
    selectedItem: selected,
),
          )
        )
      ],
    ),
  );
}


DisciplineSelectInput(txt,selected,LicenceProvider licenceController){
 return Padding(
    padding: const EdgeInsets.symmetric(horizontal:24.0,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(txt),
       Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black38)
          ),
          width: 25.w,
          height: 4.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownSearch<Discipline>(    
              compareFn: (item1, item2) => item1.id==item2.id,       
    popupProps: PopupProps.modalBottomSheet(
      showSearchBox: true,
      constraints: BoxConstraints(maxHeight: 30.h,
      minHeight: 10.h
      ),
        showSelectedItems: true,
        // disabledItemFn: (String s) => s.startsWith('I'),
    ),
    itemAsString: (item) => item.name!,
    items: licenceController.parameters!.disciplines!,
    dropdownDecoratorProps: DropDownDecoratorProps(
       dropdownSearchDecoration: InputDecoration(
          filled: false,
              // labelText: selected,
              hintText: "Choisir votre "+txt,
              
        ),
    ),
    // onChanged: (value){
    //   selected=value;
    //   licenceController.notify();
    // },
    onChanged: (value){
      selected=value;
      licenceController.selectedDiscipline=value;
      print(selected.id);
      
    },
    selectedItem: selected,
),
          )
        )
      ],
    ),
  );
}



GradeSelectInput(txt,selected,LicenceProvider licenceController){
 return Padding(
    padding: const EdgeInsets.symmetric(horizontal:24.0,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(txt),
       Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: Colors.black38)
          ),
          width: 25.w,
          height: 4.h,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownSearch<Grade>(         
              compareFn: (item1, item2) => item1.id==item2.id,  
    popupProps: PopupProps.modalBottomSheet(
      showSearchBox: true,
      constraints: BoxConstraints(maxHeight: 30.h,
      minHeight: 10.h
      ),
        showSelectedItems: true,
        // disabledItemFn: (String s) => s.startsWith('I'),
    ),
    itemAsString: (item) => item.grade!,
    items: licenceController.parameters!.grades!,
    dropdownDecoratorProps: DropDownDecoratorProps(
       dropdownSearchDecoration: InputDecoration(
          filled: false,
              // labelText: selected,
              hintText: "Choisir votre "+txt,
              
        ),
    ),
    // onChanged: (value){
    //   selected=value;
    //   licenceController.notify();
    // },
    onChanged: (value){
      selected=value;
      licenceController.selectedGrade=value;
      print(selected.id);
      
    },
    selectedItem: selected,
),
          )
        )
      ],
    ),
  );
}

 Dateinput(txt,control,context,selected,LicenceProvider licenceController){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal:24.0,vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(txt),
        InkWell(
          onTap: () async {
             DateTime? date=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1800), lastDate: DateTime.now()); 
             selected=date;
             control.text=date!.year.toString()+"-"+date.month.toString()+"-"+date.day.toString();
             licenceController.notify();
            print(date);
          },
          child: Container(
            width: 50.w,
            height: 5.h,
            child: TextFormField(
              enabled: false,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)),)),
              controller: control,
            ),
          ),
        )
      ],
    ),
  );
  // DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime(1800), lastDate: DateTime.now());
}

SearchInput(LicenceProvider licenceController,numControl,context){
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left:12.0),
      child: TextFormField(
        // onTapOutside: (){
        //   licenceController.isShadow=false
        // },
        onTapOutside: (event) {
          licenceController.isShadow=false;
          licenceController.notify();
        },
        onTap: (){
          licenceController.isShadow=true;
          licenceController.notify();
        },
        onFieldSubmitted: (newValue) {
          licenceController.findLicence(numControl.text, context);
        },
        controller: numControl,
          decoration: InputDecoration.collapsed(
        hintText: 'Rechercher',
      ),
      // trol,
      ),
    ),
  );
}



Widget AuthInput(txt,control,hide){
  return Container(
      
      
      height: 4.h,
      width: 50.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 2)
          )
        ],
         
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5))
        
      ),
      child: Padding(
        padding: const EdgeInsets.only(left:12.0),
        
        child: TextFormField(
         
         expands: false,
         // validator: (value) {
         //   return authValidator(widget.required,widget.hint,value,psdController: widget.psdControl);
         // },



         
         // toolbarOptions: ,
         // validator: authValidator(required,hint),
         // validator: (value) {
         //   if(this.required){
         //     if (value == null || value.isEmpty) {
         //       return 'Please enter some text';
         //     }
    
         //   }
           
         //   if(hint=="Phone Number"){
         //     if(int.tryParse(value!)==null){
         //       return 'Only numbers are allowed';
         //     }
         //     else{
         //       if(value.length!=8){
         //         return 'Phone number must be 8 digits';
         //       }
         //     }
         //   }
         // },
         enabled: true,
         controller: control,
         obscureText: hide,
         decoration: InputDecoration(
           
           hintText: txt,
           border: InputBorder.none,
    //        suffixIcon: trailing??(((widget.hint=="Password")||(widget.hint=="Confirm Password"))?widget.hide?IconButton(icon:Icon(Icons.remove_red_eye,), onPressed: () { 
    //         hide=false;
    // print("changed "+widget.hide.toString()+" "+(!widget.hide).toString());
    // authController.notifyListeners();
    //         },):IconButton(icon:Icon(Icons.lock,), onPressed: () { 
    //           hide=true;
    // print("changed "+widget.hide.toString()+" "+(!widget.hide).toString());
    // authController.notifyListeners();
    //          // controller.hideNShow(hide);
    //         },):null)
         ),
         
         // decoration: InputDecoration.collapsed(
           
           
         //   hintText: hint
         // ),
            ),
      ),
    );
}
