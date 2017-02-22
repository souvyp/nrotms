$('#file_upload').uploadify({    
                onCancel: function(file){
                        console.log('The file'+ file.name + 'was cancelled.')
                },
                //文件被移除出队列时触发,返回file参数
                onClearQueue: function(queueItemCount){
                    console.log(queueItemCount+'file(s) were removed frome the queue')
                },
                //当调用cancel方法且传入'*'这个参数的时候触发，其实就是移除掉整个队列里的文件时触发，上面有说cancel方法带*时取消整个上传队列
                onDestroy: function(){
                    //调用destroy方法的时候触发
                },
                onDialogClose: function(queueData){
                    console.log(queueData.filesSelected+'\n'+queueData.filesQueued+'\r\n'+queueData.filesReplaced+'\r\n'+queueData.filesCancelled+'\r\n'+ queueData.filesErrored)
                },
                //关闭掉浏览文件对话框时触发。返回queueDate参数，有以下属性：
                /*
                    filesSelected 浏览文件对话框中选取的文件数量
                    filesQueued 加入上传队列的文件数
                    filesReplaced 被替换的文件个数
                    filesCancelled 取消掉即将加入队列中的文件个数
                    filesErrored 返回错误的文件个数
                */
                onDialogOpen:function(){
                    //打开选择文件对话框时触发
                },
                onDisable:function(){
                    //禁用uploadify时触发(通过disable方法)
                },
                onEnalbe: function(){
                    //启用uploadify时触发(通过disable方法)
                },
                onFallback:function(){
                    //在初始化时检测不到浏览器有兼容性的flash版本时实触发
                },
                onInit: function(instance){
                    console.log('The queue ID is'+ instance.settings.queueID)
                },
                //每次初始化一个队列时触发，返回uploadify对象的实例
                onQueueComplete:function(queueData){
                    console.log(queueData.uploadsSuccessful+'\n'+queueData.uploadsErrored)
                },
                //队列中的文件都上传完后触发，返回queueDate参数，有以下属性：
                /*
                    uploadsSuccessful 成功上传的文件数量
                    uploadsErrored 出现错误的文件数量
                */
                onSelect: function(file){
                    console.log(file.name)
                },
                //选择每个文件增加进队列时触发，返回file参数
                onSelectError: function(file,errorCode,errorMsg){
                    console.log(errorCode)
                    console.log(this.queueData.errorMsg)
                },
                //选择文件出错时触发，返回file,erroCode,errorMsg三个参数
                /*
                    errorCode是一个包含了错误码的js对象，用来查看事件中发送的错误码，以确定错误的具体类型，可能会有以下的常量：
                    QUEUE_LIMIT_EXCEEDED:-100 选择的文件数量超过设定的最大值；
                    FILE_EXCEEDS_SIZE_LIMIT:-110 文件的大小超出设定
                    INVALID_FILETYPE:-130 选择的文件类型跟设置的不匹配

                    errorMsg 完整的错误信息，如果你不重写默认的事件处理器，可以使用‘this.queueData.errorMsg’ 存取完整的错误信息
                */
                onSWFReady: function(){
                    //swf动画加载完后触发，没有参数
                },
                onUploadComplete: function(file){
                    //在每一个文件上传成功或失败之后触发，返回上传的文件对象或返回一个错误，如果你想知道上传是否成功，最后使用onUploadSuccess或onUploadError事件
                },
                onUploadError: function(file,errorCode,erorMsg,errorString){
                },
                //一个文件完成上传但返回错误时触发，有以下参数
                /*
                    file 完成上传的文件对象
                    errorCode 返回的错误代码
                    erorMsg 返回的错误信息
                    errorString 包含所有错误细节的可读信息
                */
                onUploadProgress: function(file,bytesUploaded,bytesTotal,totalBytesUploaded,totalBytesTotal){
                    $('#pregress').html('总共需要上传'+bytesTotal+'字节，'+'已上传'+totalBytesTotal+'字节')
                },
                //每更新一个文件上传进度的时候触发,返回以下参数
                /*
                    file 正上传文件对象
                    bytesUploaded 文件已经上传的字节数
                    bytesTotal 文件的总字节数
                    totalBytesUploaded 在当前上传的操作中（所有文件）已上传的总字节数
                    totalBytesTotal 所有文件的总上传字节数
                */
                onUploadStart: function(file){
                    console.log('start update')
                },
                //每个文件即将上传前触发
                onUploadSuccess: function(file,data,respone){
                    alert( 'id: ' + file.id
　                          + ' - 索引: ' + file.index
　　　　　　　　　　　　　　　　+ ' - 文件名: ' + file.name
　　　　　　　　　　　　　　　　+ ' - 文件大小: ' + file.size
　　　　　　　　　　　　　　　　+ ' - 类型: ' + file.type
　　　　　　　　　　　　　　　　+ ' - 创建日期: ' + file.creationdate
　　　　　　　　　　　　　　　　+ ' - 修改日期: ' + file.modificationdate
　　　　　　　　　　　　　　　　+ ' - 文件状态: ' + file.filestatus
　　　　　　　　　　　　　　　　+ ' - 服务器端消息: ' + data
　　　　　　　　　　　　　　　　+ ' - 是否上传成功: ' + response);
                }
                //每个文件上传成功后触发              
})