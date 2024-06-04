import bluetoothManager from '@ohos.bluetoothManager'

try {
  bluetoothManager.enableBluetooth();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  bluetoothManager.disableBluetooth();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  let localName = bluetoothManager.getLocalName();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  let state = bluetoothManager.getState();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  let connectionState = bluetoothManager.getBtConnectionState();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  bluetoothManager.setLocalName('device_name');
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  // 实际的地址可由扫描流程获取
  bluetoothManager.pairDevice("XX:XX:XX:XX:XX:XX");
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  let result = bluetoothManager.getProfileConnectionState(bluetoothManager.ProfileId.PROFILE_A2DP_SOURCE);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  let remoteDeviceName = bluetoothManager.getRemoteDeviceName("XX:XX:XX:XX:XX:XX");
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  let remoteDeviceClass = bluetoothManager.getRemoteDeviceClass("XX:XX:XX:XX:XX:XX");
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  let devices = bluetoothManager.getPairedDevices();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  // 设置为可连接可发现才可被远端设备扫描到，可以连接。
  bluetoothManager.setBluetoothScanMode(bluetoothManager.ScanMode.SCAN_MODE_CONNECTABLE_GENERAL_DISCOVERABLE, 100);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  let scanMode = bluetoothManager.getBluetoothScanMode();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

let deviceId;
function onReceiveEvent(data) {
  deviceId = data;
}
try {
  bluetoothManager.on('bluetoothDeviceFind', onReceiveEvent);
  bluetoothManager.startBluetoothDiscovery();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  bluetoothManager.stopBluetoothDiscovery();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  // 订阅“pinRequired”配对请求事件，收到远端配对请求后设置配对确认
  function onReceivePinRequiredEvent(data) { // data为配对请求的入参，配对请求参数
    console.info('pin required  = '+ JSON.stringify(data));
    bluetoothManager.setDevicePairingConfirmation(data.deviceId, true);
  }
  bluetoothManager.on('pinRequired', onReceivePinRequiredEvent);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

function onReceiveFindEvent(data) { // data为蓝牙设备地址集合
  console.info('bluetooth device find = '+ JSON.stringify(data));
}
try {
  bluetoothManager.on('bluetoothDeviceFind', onReceiveFindEvent);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  bluetoothManager.on('bluetoothDeviceFind', onReceiveFindEvent);
  bluetoothManager.off('bluetoothDeviceFind', onReceiveFindEvent);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

let serverNumber = -1;
function serverSocket(code, number) {
  console.log('bluetooth error code: ' + code.code);
  if (code.code == 0) {
    console.log('bluetooth serverSocket Number: ' + number);
    serverNumber = number;
  }
}

let sppOption = {uuid: '00001810-0000-1000-8000-00805F9B34FB', secure: false, type: 0};
try {
  bluetoothManager.sppListen('server1', sppOption, serverSocket);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

let clientNumber = -1;
function acceptClientSocket(code, number) {
  console.log('bluetooth error code: ' + code.code);
  if (code.code == 0) {
    console.log('bluetooth clientSocket Number: ' + number);
    // 获取的clientNumber用作服务端后续读/写操作socket的id。
    clientNumber = number;
  }
}

try {
  bluetoothManager.sppAccept(serverNumber, acceptClientSocket);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

function clientSocket(code, number) {
  if (code.code != 0) {
    return;
  }
  console.log('bluetooth serverSocket Number: ' + number);
  // 获取的clientNumber用作客户端后续读/写操作socket的id。
  clientNumber = number;
}

try {
  bluetoothManager.sppConnect('XX:XX:XX:XX:XX:XX', sppOption, clientSocket);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  bluetoothManager.sppCloseServerSocket(serverNumber);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  bluetoothManager.sppCloseClientSocket(clientNumber);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

let arrayBuffer = new ArrayBuffer(8);
let data = new Uint8Array(arrayBuffer);
data[0] = 123;
try {
  bluetoothManager.sppWrite(clientNumber, arrayBuffer);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

function dataRead(dataBuffer) {
  let data = new Uint8Array(dataBuffer);
  console.log('bluetooth data is: ' + data[0]);
}

try {
  bluetoothManager.on('sppRead', clientNumber, dataRead);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  bluetoothManager.off('sppRead', clientNumber);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  let hidHost = bluetoothManager.getProfileInstance(bluetoothManager.ProfileId.PROFILE_HID_HOST);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

let gattServer = bluetoothManager.BLE.createGattServer();

try {
  let device = bluetoothManager.BLE.createGattClientDevice('XX:XX:XX:XX:XX:XX');
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  let result = bluetoothManager.BLE.getConnectedBLEDevices();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

function onReceiveBLEEvent(data) {
  console.info('BLE scan device find result = '+ JSON.stringify(data));
}

try {
  bluetoothManager.BLE.on("BLEDeviceFind", onReceiveBLEEvent);
  bluetoothManager.BLE.startBLEScan(
    [{
      deviceId:"XX:XX:XX:XX:XX:XX",
      name:"test",
      serviceUuid:"00001888-0000-1000-8000-00805f9b34fb"
    }],
    {
      interval: 500,
      dutyMode: bluetoothManager.ScanDuty.SCAN_MODE_LOW_POWER,
      matchMode: bluetoothManager.MatchMode.MATCH_MODE_AGGRESSIVE,
    }
  );
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  bluetoothManager.BLE.stopBLEScan();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

function onReceiveEvent_(data) {
  console.info('bluetooth device find = '+ JSON.stringify(data));
}
try {
  bluetoothManager.BLE.on('BLEDeviceFind', onReceiveEvent_);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  bluetoothManager.BLE.on('BLEDeviceFind', onReceiveEvent_);
  bluetoothManager.BLE.off('BLEDeviceFind', onReceiveEvent_);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  let a2dpSrc = bluetoothManager.getProfileInstance(bluetoothManager.ProfileId.PROFILE_A2DP_SOURCE) as bluetoothManager.A2dpSourceProfile;
  let retArray = a2dpSrc.getConnectionDevices();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  let a2dpSrc = bluetoothManager.getProfileInstance(bluetoothManager.ProfileId.PROFILE_A2DP_SOURCE) as bluetoothManager.A2dpSourceProfile;
  let ret = a2dpSrc.getDeviceState('XX:XX:XX:XX:XX:XX'); // 获取设备profile的连接状态。
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

try {
  let a2dpSrc = bluetoothManager.getProfileInstance(bluetoothManager.ProfileId.PROFILE_A2DP_SOURCE) as bluetoothManager.A2dpSourceProfile;
  a2dpSrc.connect('XX:XX:XX:XX:XX:XX');
  a2dpSrc.disconnect('XX:XX:XX:XX:XX:XX');
  let state = a2dpSrc.getPlayingState('XX:XX:XX:XX:XX:XX');
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

function onReceiveStateEvent(data) {
  console.info('a2dp state = '+ JSON.stringify(data));
}
let a2dpSrc = bluetoothManager.getProfileInstance(bluetoothManager.ProfileId.PROFILE_A2DP_SOURCE) as bluetoothManager.A2dpSourceProfile;
a2dpSrc.on('connectionStateChange', onReceiveStateEvent);
a2dpSrc.off('connectionStateChange', onReceiveStateEvent);


let manufactureValueBuffer = new Uint8Array(4);
manufactureValueBuffer[0] = 1;
manufactureValueBuffer[1] = 2;
manufactureValueBuffer[2] = 3;
manufactureValueBuffer[3] = 4;

let serviceValueBuffer = new Uint8Array(4);
serviceValueBuffer[0] = 4;
serviceValueBuffer[1] = 6;
serviceValueBuffer[2] = 7;
serviceValueBuffer[3] = 8;
console.info('manufactureValueBuffer = '+ JSON.stringify(manufactureValueBuffer));
console.info('serviceValueBuffer = '+ JSON.stringify(serviceValueBuffer));

let gattServer_ = bluetoothManager.BLE.createGattServer();
try {
  gattServer_.startAdvertising({
    interval: 150,
    txPower: 60,
    connectable: true,
  },{
    serviceUuids:["00001888-0000-1000-8000-00805f9b34fb"],
    manufactureData:[{
      manufactureId:4567,
      manufactureValue:manufactureValueBuffer.buffer
    }],
    serviceData:[{
      serviceUuid:"00001888-0000-1000-8000-00805f9b34fb",
      serviceValue:serviceValueBuffer.buffer
    }],
  },{
    serviceUuids:["00001889-0000-1000-8000-00805f9b34fb"],
    manufactureData:[{
      manufactureId:1789,
      manufactureValue:manufactureValueBuffer.buffer
    }],
    serviceData:[{
      serviceUuid:"00001889-0000-1000-8000-00805f9b34fb",
      serviceValue:serviceValueBuffer.buffer
    }],
  });
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

let server = bluetoothManager.BLE.createGattServer();
try {
  server.stopAdvertising();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

// 创建descriptors
let descriptors = [];
let arrayBuffer_ = new ArrayBuffer(8);
let descV = new Uint8Array(arrayBuffer);
descV[0] = 11;
let descriptor = {serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
  characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
  descriptorUuid: '00002902-0000-1000-8000-00805F9B34FB', descriptorValue: arrayBuffer_};
descriptors[0] = descriptor;

// 创建characteristics
let characteristics = [];
let arrayBufferC = new ArrayBuffer(8);
let cccV = new Uint8Array(arrayBufferC);
cccV[0] = 1;
let characteristic = {serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
  characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB', characteristicValue: arrayBufferC, descriptors:descriptors};
let characteristicN = {serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
  characteristicUuid: '00001821-0000-1000-8000-00805F9B34FB', characteristicValue: arrayBufferC, descriptors:descriptors};
characteristics[0] = characteristic;

// 创建gattService
let gattService = {serviceUuid:'00001810-0000-1000-8000-00805F9B34FB', isPrimary: true, characteristics:characteristics, includeServices:[]};

let _gattServer = bluetoothManager.BLE.createGattServer();
try {
  _gattServer.addService(gattService);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}
try {
  _gattServer.removeService('00001810-0000-1000-8000-00805F9B34FB');
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}
try {
  _gattServer.close();
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

// 创建descriptors
let descriptors_ = [];
let arrayBuffer__ = new ArrayBuffer(8);
let descV_ = new Uint8Array(arrayBuffer__);
descV_[0] = 11;
let descriptor_ = {serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
  characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
  descriptorUuid: '00002902-0000-1000-8000-00805F9B34FB', descriptorValue: arrayBuffer__};
descriptors_[0] = descriptor_;
let arrayBufferC_ = new ArrayBuffer(8);
let characteristic_ = {serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
  characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB', characteristicValue: arrayBufferC_, descriptors:descriptors_};
let notifyCharacteristic = {serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
  characteristicUuid: '00001821-0000-1000-8000-00805F9B34FB', characteristicValue: characteristic_.characteristicValue, confirm: false};
let server_ = bluetoothManager.BLE.createGattServer();
try {
  server_.notifyCharacteristicChanged('XX:XX:XX:XX:XX:XX', notifyCharacteristic);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}

/* send response */
let arrayBufferCCC = new ArrayBuffer(8);
let cccValue = new Uint8Array(arrayBufferCCC);
cccValue[0] = 1123;
let serverResponse = {
  "deviceId": "XX:XX:XX:XX:XX:XX",
  "transId": 0,
  "status": 0,
  "offset": 0,
  "value": arrayBufferCCC,
};

let gattServerResp = bluetoothManager.BLE.createGattServer();
try {
  gattServerResp.sendResponse(serverResponse);
} catch (err) {
  console.error("errCode:" + err.code + ",errMessage:" + err.message);
}




