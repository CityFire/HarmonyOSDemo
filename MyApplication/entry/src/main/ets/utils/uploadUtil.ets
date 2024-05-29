import request from '@ohos.request';

let uploadTask;
let uploadConfig = {
  url: 'http://www.example.com', //需要手动替换为真实服务器地址
  header: { 'Accept': '*/*' },
  method: "POST",
  files: [{ filename: "test", name: "test", uri: "internal://cache/test.jpg", type: "jpg" }],
  data: [{ name: "name123", value: "123" }],
};
try {
  request.uploadFile(globalThis.abilityContext, uploadConfig).then((data) => {
    uploadTask = data;
  }).catch((err) => {
    console.error('Failed to request the upload. Cause: ' + JSON.stringify(err));
  });

  /*
  request.uploadFile(globalThis.abilityContext, uploadConfig, (err, data) => {
    if (err) {
      console.error('Failed to request the upload. Cause: ' + JSON.stringify(err));
      return;
    }
    uploadTask = data;
  });
  */
} catch (err) {
  console.error('err.code : ' + err.code + ', err.message : ' + err.message);
}

/*
request.upload(uploadConfig).then((data) => { // deprecated
  uploadTask = data;
}).catch((err) => {
  console.error('Failed to request the upload. Cause: ' + JSON.stringify(err));
})

* request.upload(uploadConfig, (err, data) => {
    if (err) {
        console.error('Failed to request the upload. Cause: ' + JSON.stringify(err));
        return;
    }
    uploadTask = data;
});
*/

let upProgressCallback = (uploadedSize, totalSize) => {
  console.info("upload totalSize:" + totalSize + "  uploadedSize:" + uploadedSize);
};
uploadTask.on('progress', upProgressCallback);

let headerCallback = (headers) => {
  console.info("upOnHeader headers:" + JSON.stringify(headers));
};
uploadTask.on('headerReceive', headerCallback);

let upCompleteCallback = (taskStates) => {
  for (let i = 0; i < taskStates.length; i++) {
    console.info("upOnComplete taskState:" + JSON.stringify(taskStates[i]));
  }
};
uploadTask.on('complete', upCompleteCallback);

let upFailCallback = (taskStates) => {
  for (let i = 0; i < taskStates.length; i++ ) {
    console.info("upOnFail taskState:" + JSON.stringify(taskStates[i]));
  }
};
uploadTask.on('fail', upFailCallback);

let upProgressCallback_ = (uploadedSize, totalSize) => {
  console.info('Upload delete progress notification.' + 'totalSize:' + totalSize + 'uploadedSize:' + uploadedSize);
};
uploadTask.off('progress', upProgressCallback_);

let headerCallback_ = (header) => {
  console.info(`Upload delete headerReceive notification. header: ${JSON.stringify(header)}`);
};
uploadTask.off('headerReceive', headerCallback_);

let upCompleteCallback_ = (taskStates) => {
  console.info('Upload delete complete notification.');
  for (let i = 0; i < taskStates.length; i++ ) {
    console.info('taskState:' + JSON.stringify(taskStates[i]));
  }
};
uploadTask.off('complete', upCompleteCallback_);
let upFailCallback_ = (taskStates) => {
  console.info('Upload delete fail notification.');
  for (let i = 0; i < taskStates.length; i++ ) {
    console.info('taskState:' + JSON.stringify(taskStates[i]));
  }
};
uploadTask.off('fail', upFailCallback_);

uploadTask.delete().then((result) => {
  if (result) {
    console.info('Upload task removed successfully. ');
  } else {
    console.error('Failed to remove the upload task. ');
  }
}).catch((err) => {
  console.error('Failed to remove the upload task. Cause: ' + JSON.stringify(err));
});

uploadTask.delete((err, result) => {
  if (err) {
    console.error('Failed to remove the upload task. Cause: ' + JSON.stringify(err));
    return;
  }
  if (result) {
    console.info('Upload task removed successfully.');
  } else {
    console.error('Failed to remove the upload task.');
  }
});

/*
uploadTask.remove().then((result) => {
  if (result) {
    console.info('Upload task removed successfully. ');
  } else {
    console.error('Failed to remove the upload task. ');
  }
}).catch((err) => {
  console.error('Failed to remove the upload task. Cause: ' + JSON.stringify(err));
});
*
uploadTask.remove((err, result) => {
    if (err) {
        console.error('Failed to remove the upload task. Cause: ' + JSON.stringify(err));
        return;
    }
    if (result) {
        console.info('Upload task removed successfully.');
    } else {
        console.error('Failed to remove the upload task.');
    }
});
*/

let downloadTask;
try {
  request.downloadFile(globalThis.abilityContext, { url: 'https://xxxx/xxx.hap' }).then((data) => {
    downloadTask = data;
  }).catch((err) => {
    console.error('Failed to request the download. Cause: ' + JSON.stringify(err));
  })
} catch (err) {
  console.error('err.code : ' + err.code + ', err.message : ' + err.message);
}

try {
  request.downloadFile(globalThis.abilityContext, { url: 'https://xxxx/xxxxx.hap',
    filePath: 'xxx/xxxxx.hap'}, (err, data) => {
        if (err) {
          console.error('Failed to request the download. Cause: ' + JSON.stringify(err));
          return;
        }
    downloadTask = data;
  });
} catch (err) {
  console.error('err.code : ' + err.code + ', err.message : ' + err.message);
}

let progresCallback = (receivedSize, totalSize) => {
  console.info("download receivedSize:" + receivedSize + " totalSize:" + totalSize);
};
downloadTask.on('progress', progresCallback);

let progresCallback_ = (receivedSize, totalSize) => {
  console.info('Download delete progress notification.' + 'receivedSize:' + receivedSize + 'totalSize:' + totalSize);
};
downloadTask .off('progress',progresCallback_);

let completeCallback = () => {
  console.info('Download task completed.');
};
downloadTask.on('complete', completeCallback);
let pauseCallback = () => {
  console.info('Download task pause.');
};
downloadTask.on('pause', pauseCallback);
let removeCallback = () => {
  console.info('Download task remove.');
};
downloadTask.on('remove', removeCallback);

let completeCallback_del = () => {
  console.info('Download delete complete notification.');
};
downloadTask.off('complete', completeCallback_del);
let pauseCallback_del = () => {
  console.info('Download delete pause notification.');
};
downloadTask.off('pause', pauseCallback_del);
let removeCallback_del = () => {
  console.info('Download delete remove notification.');
};
downloadTask.off('remove', removeCallback_del);

let failCallback = (err) => {
  console.info('Download task failed. Cause:' + err);
};
downloadTask.on('fail', failCallback);

let failCallback_d = (err) => {
  console.info(`Download delete fail notification. err: ${err.message}`);
};
downloadTask.off('fail', failCallback_d);


downloadTask.delete().then((result) => {
  if (result) {
    console.info('Download task removed.');
  } else {
    console.error('Failed to remove the download task.');
  }
}).catch ((err) => {
  console.error('Failed to remove the download task.');
});


downloadTask.delete((err, result) => {
  if (err) {
    console.error('Failed to remove the download task.');
    return;
  }
  if (result) {
    console.info('Download task removed.');
  } else {
    console.error('Failed to remove the download task.');
  }
});

// 查询下载任务，异步方法，使用promise形式返回DownloadInfo里的信息。
downloadTask.getTaskInfo().then((downloadInfo) => {
  console.info('Download task queried. Data:' + JSON.stringify(downloadInfo))
}) .catch((err) => {
  console.error('Failed to query the download task. Cause:' + err)
});

downloadTask.getTaskInfo((err, downloadInfo) => {
  if (err) {
    console.error('Failed to query the download mimeType. Cause:' + JSON.stringify(err));
  } else {
    console.info('download query success. data:'+ JSON.stringify(downloadInfo));
  }
});

downloadTask.getTaskMimeType().then((data) => {
  console.info('Download task queried. Data:' + JSON.stringify(data));
}).catch((err) => {
  console.error('Failed to query the download MimeType. Cause:' + JSON.stringify(err))
});

downloadTask.getTaskMimeType((err, data) => {
  if (err) {
    console.error('Failed to query the download mimeType. Cause:' + JSON.stringify(err));
  } else {
    console.info('Download task queried. data:' + JSON.stringify(data));
  }
});

downloadTask.suspend().then((result) => {
  if (result) {
    console.info('Download task paused. ');
  } else {
    console.error('Failed to pause the download task. Cause:' + JSON.stringify(result));
  }
}).catch((err) => {
  console.error('Failed to pause the download task. Cause:' + JSON.stringify(err));
});

downloadTask.suspend((err, result) => {
  if (err) {
    console.error('Failed to pause the download task. Cause:' + JSON.stringify(err));
    return;
  }
  if (result) {
    console.info('Download task paused. ');
  } else {
    console.error('Failed to pause the download task. Cause:' + JSON.stringify(result));
  }
});

downloadTask.restore().then((result) => {
  if (result) {
    console.info('Download task resumed.')
  } else {
    console.error('Failed to resume the download task. ');
  }
  console.info('Download task resumed.')
}).catch((err) => {
  console.error('Failed to resume the download task. Cause:' + err);
});

// 重新启动暂停的下载任务，异步方法，使用callback形式返回结果。
downloadTask.restore((err, result) => {
  if (err) {
    console.error('Failed to resume the download task. Cause:' + err);
    return;
  }
  if (result) {
    console.info('Download task resumed.');
  } else {
    console.error('Failed to resume the download task.');
  }
});
