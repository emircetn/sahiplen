import 'package:flutter/material.dart';
import 'package:sahiplen/core/components/widgets/avatar/profile_avatar.dart';
import 'package:sahiplen/core/components/widgets/item/profile_list_item.dart';
import 'package:sahiplen/core/constants/router_constants.dart';
import 'package:sahiplen/core/extensions/app_extensions.dart';
import 'package:sahiplen/core/base/view/base_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'profile_view_model.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      viewModel: ProfileViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, ProfileViewModel viewModel) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appBar(context, viewModel),
          body: body(viewModel, context),
        );
      },
    );
  }

  AppBar appBar(BuildContext context, ProfileViewModel viewModel) {
    return AppBar(
      title: Text('Sahiplen', style: context.textTheme.headline6!.copyWith(color: context.theme.primaryColorDark)),
      centerTitle: true,
      actions: [
        IconButton(icon: Icon(Icons.exit_to_app), onPressed: () async => await viewModel.signOut()),
      ],
    );
  }

  SafeArea body(ProfileViewModel viewModel, BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              headerField(viewModel, context),
              items(viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Column headerField(ProfileViewModel viewModel, BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),
        ProfileAvatar(appUser: viewModel.appUser!),
        SizedBox(height: 5.h),
        Text(
          viewModel.appUser!.displayName!.toUpperCase(),
          style: context.textTheme.headline6,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }

  Column items(ProfileViewModel viewModel) {
    return Column(
      children: [
        ProfileListItem(
          titleText: 'Profili G??ncelle',
          subtitleText: 'Bilgilerini g??ncelle',
          icon: Icons.person,
          onTap: () async => await viewModel.navigationService.pushNamed(RouteConstant.EDIT_PROFILE_PAGE_ROUTE),
        ),
        ProfileListItem(
          titleText: '??lan Olu??tur',
          subtitleText: 'Ilan olu??turarak evcil hayvan??n?? sahiplecek ki??ileri bul',
          icon: Icons.create,
          onTap: () async => await viewModel.navigationService.pushNamed(RouteConstant.CREATE_ADVERTISEMENT_PAGE_ROUTE),
        ),
        ProfileListItem(
          titleText: '??lanlar??n',
          subtitleText: 'Ilanlar??n?? g??r??nt??le',
          icon: Icons.featured_play_list,
          onTap: () async => await viewModel.navigationService.pushNamed(RouteConstant.USER_ADVERTOSEMENT_PAGE_ROUTE),
        ),
      ],
    );
  }
}
