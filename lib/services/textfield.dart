import 'package:colab/theme/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool? enabled;
  final TextEditingController? controller;

  const CustomTextField({Key? key, 
     this.label,
     this.hintText,
     this.enabled,
     this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,
      enabled: enabled,
      controller: controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      hintStyle: const TextStyle(color: Colors.black,),
      enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
              ),
      focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!),
              ),
      errorBorder: InputBorder.none,
      disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
      ),
      ),
      maxLines: 4,
       style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,height: 0.4),
    );
  }
}

class CustomTextFieldGrey extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool? enabled;
  final TextEditingController? controller;

  const CustomTextFieldGrey({Key? key, 
     this.label,
     this.hintText,
     this.enabled,
     this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,
      enabled: enabled,
      controller: controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
      filled: true,
      fillColor: Colors.grey[200],
      hintStyle: const TextStyle(color: Colors.black,),
      enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
              ),
      focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!),
              ),
      errorBorder: InputBorder.none,
      disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
      ),
      ),
       maxLines: null,
       style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.black),
    );
  }
}

class CustomTextField3 extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool? enabled;
  final TextEditingController? controller;

  const CustomTextField3({Key? key, 
     this.label,
     this.hintText,
     this.enabled,
     this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    TextField(
      cursorHeight: 20,
      enabled: enabled,
      controller: controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey[200],
      hintStyle: const TextStyle(color: Colors.grey,fontSize: 14),
      enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
              ),
      focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!),
              ),
      errorBorder: InputBorder.none,
      disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
      ),
      ),
       maxLines: null,
       style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
    );
  }
}

class CustomTextFieldArea extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool? enabled;
  final TextEditingController? controller;

  const CustomTextFieldArea({Key? key, 
     this.label,
     this.hintText,
     this.enabled,
     this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    TextField(
      cursorHeight: 20,
      enabled: enabled,
      controller: controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
      hintStyle: const TextStyle(color: Colors.grey,fontSize: 14),
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey[200],
      enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
              ),
      focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!),
              ),
      errorBorder: InputBorder.none,
      disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
      ),
      ),
       maxLines: 4,
       style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
    );
  }
}

class CustomTextField2 extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool? enabled;
  final TextEditingController? controller;
  // ignore: prefer_typing_uninitialized_variables
  final onChanged;

  const CustomTextField2({Key? key, 
     this.label,
     this.hintText,
     this.enabled,
     this.controller,
     this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,
      onChanged: onChanged,
      enabled: enabled,
      controller: controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
      filled: true,
      hintText: hintText,
      fillColor: Colors.grey[200],
      hintStyle: const TextStyle(color: Colors.grey,),
      enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
              ),
      focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!),
              ),
      errorBorder: InputBorder.none,
      disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
      ),
      ),
       maxLines: null,
       style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,),
    );
  }
}

class CustomTextFieldForNumber extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool? enabled;
  final TextEditingController? controller;
  // ignore: prefer_typing_uninitialized_variables
  final onChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onSubmitted;
  // ignore: prefer_typing_uninitialized_variables
  final readOnly;

  const CustomTextFieldForNumber({Key? key, 
     this.label,
     this.hintText,
     this.enabled,
     this.readOnly,
     this.controller,
     this.onChanged,
     this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,
      onSubmitted: onSubmitted,
      keyboardType:TextInputType.number,
      onChanged: onChanged,
      enabled: enabled,
      controller: controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
      filled: true,
      hintText: hintText,
      fillColor: Colors.grey[200],
      hintStyle: const TextStyle(color: Colors.grey,),
      enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
              ),
      focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!),
              ),
      errorBorder: InputBorder.none,
      disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
      ),
      ),
       maxLines: null,
       style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,height: 0),
    );
  }
}


class CustomTextFieldForNumber2 extends StatelessWidget {
  final String? label;
  final String? hintText;
  final bool? enabled;
  final TextEditingController? controller;
  // ignore: prefer_typing_uninitialized_variables
  final onChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onSubmitted;
  // ignore: prefer_typing_uninitialized_variables
  final readOnly;

  const CustomTextFieldForNumber2({Key? key, 
     this.label,
     this.hintText,
     this.enabled,
     this.readOnly,
     this.controller,
     this.onChanged,
     this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 20,
      readOnly: readOnly,
      onSubmitted: onSubmitted,
      keyboardType:TextInputType.number,
      onChanged: onChanged,
      enabled: enabled,
      controller: controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
      filled: true,
      hintText: hintText,
      fillColor: Colors.grey[200],
      hintStyle: const TextStyle(color: Colors.grey,),
      enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
              ),
      focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!),
              ),
      errorBorder: InputBorder.none,
      disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(
            width: 1, color:Colors.grey[300]!), 
      ),
      ),
       maxLines: null,
       style: textStyleHeadline2.copyWith(fontWeight: FontWeight.w400,fontSize: 16,height: 0),
    );
  }
}