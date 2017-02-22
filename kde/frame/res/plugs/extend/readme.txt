$('#file_upload').uploadify({    
                onCancel: function(file){
                        console.log('The file'+ file.name + 'was cancelled.')
                },
                //�ļ����Ƴ�������ʱ����,����file����
                onClearQueue: function(queueItemCount){
                    console.log(queueItemCount+'file(s) were removed frome the queue')
                },
                //������cancel�����Ҵ���'*'���������ʱ�򴥷�����ʵ�����Ƴ���������������ļ�ʱ������������˵cancel������*ʱȡ�������ϴ�����
                onDestroy: function(){
                    //����destroy������ʱ�򴥷�
                },
                onDialogClose: function(queueData){
                    console.log(queueData.filesSelected+'\n'+queueData.filesQueued+'\r\n'+queueData.filesReplaced+'\r\n'+queueData.filesCancelled+'\r\n'+ queueData.filesErrored)
                },
                //�رյ�����ļ��Ի���ʱ����������queueDate���������������ԣ�
                /*
                    filesSelected ����ļ��Ի�����ѡȡ���ļ�����
                    filesQueued �����ϴ����е��ļ���
                    filesReplaced ���滻���ļ�����
                    filesCancelled ȡ����������������е��ļ�����
                    filesErrored ���ش�����ļ�����
                */
                onDialogOpen:function(){
                    //��ѡ���ļ��Ի���ʱ����
                },
                onDisable:function(){
                    //����uploadifyʱ����(ͨ��disable����)
                },
                onEnalbe: function(){
                    //����uploadifyʱ����(ͨ��disable����)
                },
                onFallback:function(){
                    //�ڳ�ʼ��ʱ��ⲻ��������м����Ե�flash�汾ʱʵ����
                },
                onInit: function(instance){
                    console.log('The queue ID is'+ instance.settings.queueID)
                },
                //ÿ�γ�ʼ��һ������ʱ����������uploadify�����ʵ��
                onQueueComplete:function(queueData){
                    console.log(queueData.uploadsSuccessful+'\n'+queueData.uploadsErrored)
                },
                //�����е��ļ����ϴ���󴥷�������queueDate���������������ԣ�
                /*
                    uploadsSuccessful �ɹ��ϴ����ļ�����
                    uploadsErrored ���ִ�����ļ�����
                */
                onSelect: function(file){
                    console.log(file.name)
                },
                //ѡ��ÿ���ļ����ӽ�����ʱ����������file����
                onSelectError: function(file,errorCode,errorMsg){
                    console.log(errorCode)
                    console.log(this.queueData.errorMsg)
                },
                //ѡ���ļ�����ʱ����������file,erroCode,errorMsg��������
                /*
                    errorCode��һ�������˴������js���������鿴�¼��з��͵Ĵ����룬��ȷ������ľ������ͣ����ܻ������µĳ�����
                    QUEUE_LIMIT_EXCEEDED:-100 ѡ����ļ����������趨�����ֵ��
                    FILE_EXCEEDS_SIZE_LIMIT:-110 �ļ��Ĵ�С�����趨
                    INVALID_FILETYPE:-130 ѡ����ļ����͸����õĲ�ƥ��

                    errorMsg �����Ĵ�����Ϣ������㲻��дĬ�ϵ��¼�������������ʹ�á�this.queueData.errorMsg�� ��ȡ�����Ĵ�����Ϣ
                */
                onSWFReady: function(){
                    //swf����������󴥷���û�в���
                },
                onUploadComplete: function(file){
                    //��ÿһ���ļ��ϴ��ɹ���ʧ��֮�󴥷��������ϴ����ļ�����򷵻�һ�������������֪���ϴ��Ƿ�ɹ������ʹ��onUploadSuccess��onUploadError�¼�
                },
                onUploadError: function(file,errorCode,erorMsg,errorString){
                },
                //һ���ļ�����ϴ������ش���ʱ�����������²���
                /*
                    file ����ϴ����ļ�����
                    errorCode ���صĴ������
                    erorMsg ���صĴ�����Ϣ
                    errorString �������д���ϸ�ڵĿɶ���Ϣ
                */
                onUploadProgress: function(file,bytesUploaded,bytesTotal,totalBytesUploaded,totalBytesTotal){
                    $('#pregress').html('�ܹ���Ҫ�ϴ�'+bytesTotal+'�ֽڣ�'+'���ϴ�'+totalBytesTotal+'�ֽ�')
                },
                //ÿ����һ���ļ��ϴ����ȵ�ʱ�򴥷�,�������²���
                /*
                    file ���ϴ��ļ�����
                    bytesUploaded �ļ��Ѿ��ϴ����ֽ���
                    bytesTotal �ļ������ֽ���
                    totalBytesUploaded �ڵ�ǰ�ϴ��Ĳ����У������ļ������ϴ������ֽ���
                    totalBytesTotal �����ļ������ϴ��ֽ���
                */
                onUploadStart: function(file){
                    console.log('start update')
                },
                //ÿ���ļ������ϴ�ǰ����
                onUploadSuccess: function(file,data,respone){
                    alert( 'id: ' + file.id
��                          + ' - ����: ' + file.index
��������������������������������+ ' - �ļ���: ' + file.name
��������������������������������+ ' - �ļ���С: ' + file.size
��������������������������������+ ' - ����: ' + file.type
��������������������������������+ ' - ��������: ' + file.creationdate
��������������������������������+ ' - �޸�����: ' + file.modificationdate
��������������������������������+ ' - �ļ�״̬: ' + file.filestatus
��������������������������������+ ' - ����������Ϣ: ' + data
��������������������������������+ ' - �Ƿ��ϴ��ɹ�: ' + response);
                }
                //ÿ���ļ��ϴ��ɹ��󴥷�              
})