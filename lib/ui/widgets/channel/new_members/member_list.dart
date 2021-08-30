import 'package:capybara_app/domain/entities/auth/user.dart';
import 'package:capybara_app/ui/widgets/channel/new_members/member_list_tile.dart';
import 'package:flutter/material.dart';

class MemberList extends StatelessWidget {
  final _users = [
    User(id: 1, email: 'user1@user.com', username: 'User1'),
    User(id: 2, email: 'user2@user.com', username: 'User2'),
    User(id: 3, email: 'user3@user.com', username: 'User3'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: this._users.length,
      itemBuilder: (ctx, i) => MemberListTile(
        user: this._users[i],
      ),
    );
  }
}
