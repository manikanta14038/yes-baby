//ignore_for_file:prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yes_baby/utils/screen_size.dart';

loginField(context,
    {text,
    icon,
    controller,
    keyboard,
    enabled,
    focusNode,
    onSubmit,
    obscureText,
    obscureTap}) {
  return Container(
    height: height(context) * 0.09,
    margin: EdgeInsets.symmetric(horizontal: 15),
    child: Stack(
      children: [
        Positioned(
          top: 10,
          child: Container(
            height: height(context) * 0.055,
            width: width(context) * 0.8,
            padding: EdgeInsets.only(
              left: width(context) * 0.175,
              right: width(context) * 0.05,
              bottom: 6,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff0792EF).withOpacity(0.3),
                  blurRadius: 4,
                ),
              ],
            ),
            child: TextFormField(
              enabled: enabled ?? true,
              obscureText: obscureText ?? false,
              controller: controller,
              onFieldSubmitted: onSubmit,
              style: GoogleFonts.montserrat(
                fontSize: 12,
              ),
              validator: (v) {
                if (v!.isEmpty) return 'Cannot be empty field';
              },
              focusNode: focusNode,
              keyboardType: keyboard ?? TextInputType.name,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: text,
                hintStyle: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                suffixIcon: obscureText != null
                    ? InkWell(
                        onTap: obscureTap,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility_rounded,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : SizedBox(height: 0, width: 0),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 14,
          left: 0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xff0792EF).withOpacity(0.3),
                  blurRadius: 4,
                ),
              ],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: width(context) * 0.075,
              child: Center(
                child: Image(
                  height: 16,
                  image: AssetImage('images/$icon.png'),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

loginDropField(context,
    {text,
    icon,
    focusNode,
    onChanged,
    required List list,
    sufixIcon,
    onTap,
    required String value}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height(context) * 0.09,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            child: Container(
              height: height(context) * 0.05,
              width: width(context) * 0.8,
              padding: EdgeInsets.only(left: width(context) * 0.18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff0792EF).withOpacity(0.3),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: DropdownButton(
                  style: GoogleFonts.montserrat(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  isExpanded: true,
                  hint: Text(text ?? ''),
                  icon: sufixIcon ??
                      Icon(
                        Icons.arrow_drop_down,
                        size: 35,
                        color: Color(0xffD2A776),
                      ),
                  underline: Container(height: 0),
                  onChanged: onChanged,
                  items: list
                      .map((e) => DropdownMenuItem(
                            value: e[value],
                            child: Text(e[value]),
                          ))
                      .toList()),
            ),
          ),
          Positioned(
            bottom: 14,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff0792EF).withOpacity(0.3),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: width(context) * 0.075,
                child: Center(
                  child: Image(
                    height: 16,
                    image: AssetImage('images/$icon.png'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
