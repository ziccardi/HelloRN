/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React, { Component } from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  FlatList,
  Alert,
} from 'react-native';

import NotifService from './NotifService';

import {
  Header,
  LearnMoreLinks,
  Colors,
  DebugInstructions,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

const DATA = [
  {key: '0', text: 'text0'},
  {key: '1', text: 'text1'},
  {key: '2', text: 'text2'},
];

function Item({title}) {
  return (
    <View style={styles.item}>
      <Text style={styles.message}>{title}</Text>
    </View>
  );
}

export class App extends Component {
  constructor(props) {
    super(props);
    this.notif = new NotifService(
      this.onRegister.bind(this),
      this.onNotif.bind(this),
    );
  }
  render() {
    console.log('Rendering');
    return (
      <>
        <StatusBar barStyle="dark-content" />
        <SafeAreaView>
          <View>
            <Text style={styles.header}>Notifications</Text>
            <FlatList
              style={styles.messageList}
              data={DATA}
              renderItem={({item}) => <Item title={item.text} />}
            />
          </View>
        </SafeAreaView>
      </>
    );
  }

  onRegister(token) {
    Alert.alert('Registered !', JSON.stringify(token));
    console.log(token);
    this.setState({registerToken: token.token, fcmRegistered: true});
  }

  onNotif(notif) {
    console.log(notif);
    Alert.alert(notif.title, notif.message);
  }
}

const styles = StyleSheet.create({
  header: {
    backgroundColor: '#ff9800',
    lineHeight: 56,
    paddingLeft: 16,
    fontSize: 20,
    fontWeight: '500',
    //position: 'fixed',
    left: 0,
    right: 0,
    color: '#fff',
    textAlign: 'center',
  },
  messageList: {
    backgroundColor: '#000',
    height: '100%',
  },
  item: {
    height: 56,
    flex: 1,
    justifyContent: 'center',
    paddingLeft: 10,
    paddingRight: 10,
  },
  message: {
    color: '#fff',
  },
});

export default App;
