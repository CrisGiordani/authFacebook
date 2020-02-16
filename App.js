/* eslint-disable prettier/prettier */

import React, { Fragment, Component } from 'react';
import { SafeAreaView, View, Text, ActivityIndicator, StatusBar, StyleSheet } from 'react-native';
import { LoginButton, AccessToken, GraphRequest, GraphRequestManager } from 'react-native-fbsdk';

export default class App extends Component {

  state = {
    loading: false,
    user: null,
  };

  getUserCallback = (error, result) => {
    if (error) {
      console.log('error', error);
    } else {
      this.setState({ user: result, loading: false });
    }
  }
  getUserInfo = (token) => {
    const infoRequest = new GraphRequest('/me', {
      accessToken: token,
      parameters: {
        fields: {
          string: 'email, name',
        },
      },
    }, this.getUserCallback);

    new GraphRequestManager().addRequest(infoRequest).start();
  }
  render() {
    return (
      <Fragment>
        <StatusBar barStyle="dark-content" />
        <SafeAreaView style={styles.container}>

          <LoginButton
            permissions={['public_profile', 'email']}
            onLoginFinished={async (error, result) => {
              if (error) {
                console.log('auth error', error);
              } else if (result.isCancelled) {
                console.log('isCancelled');
              } else {
                const accessData = await AccessToken.getCurrentAccessToken();
                this.setState({ loading: true });
                this.setState({ user: null });
                this.getUserInfo(accessData.accessToken);
              }
            }}
            onLogoutFinished={() => {
              this.setState({ user: null });
            }}
          />
          <View>
            {this.state.loading && <ActivityIndicator />}
            {this.state.user && (
              <Fragment>
                <Text style={styles.user}>{this.state.user.name}</Text>
                <Text style={styles.email}>{this.state.user.email}</Text>
              </Fragment>
            )}
          </View>

        </SafeAreaView>
      </Fragment>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    alignItems: 'center',
    justifyContent: 'center',
  },
  user: {
    fontWeight: 'bold',
    paddingTop: 20,
  },
  email: {
    fontSize: 12,
  },
});
