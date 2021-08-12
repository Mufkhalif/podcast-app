import 'package:flutter/material.dart';
import 'package:podcast_app/blocs/app_bloc/app_state.dart';
import 'package:podcast_app/ui/home/home_page.dart';
import 'package:podcast_app/ui/login/login_page.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
