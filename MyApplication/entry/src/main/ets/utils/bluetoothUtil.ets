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







