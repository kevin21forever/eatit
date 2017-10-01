// 图片上传demo
jQuery(function() {
    var $ = jQuery,
        $list = $('#imageList'),
    // 优化retina, 在retina下这个值是2
        ratio = window.devicePixelRatio || 1,

    // 缩略图大小
        thumbnailWidth = 700 * ratio,
        thumbnailHeight = 480 * ratio,
     // 所有文件的进度信息，key为file id
        percentages = {},
    // Web Uploader实例
        uploader;

    // 初始化Web Uploader
    uploader = WebUploader.create({

        // 自动上传。
        auto: true,
        
        // 需要的参数
        formData:{"restaurantId": $("#restaurantId").val()},

        // swf文件路径
        swf: './Uploader.swf',

        // 文件接收服务端。
        server: './upload/image',
        
        // 最多上传多少张
        fileNumLimit: 9,

        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#filePicker',

        // 只允许选择文件，可选。
        accept: {
            title: 'Images',
            extensions: 'jpg,gif,png,jpeg',
            mimeTypes: 'image/*'
        }
    });

    // 当有文件添加进来的时候
    uploader.on( 'fileQueued', function( file ) {
    	addFile(file);
    });

    // 文件上传过程中创建进度条实时显示。
    uploader.on('uploadProgress', function( file, percentage ) {
        var $li = $( '#'+file.id ),
            $percent = $li.find('.progress span');
        // 避免重复创建
        if ( !$percent.length ) {
            $percent = $('<p class="progress"><span></span></p>').appendTo( $li ).find('span');
        }

        $percent.css('width', percentage * 100 + '%' );
    });

    // 文件上传成功，给item添加成功class, 用样式标记上传成功。
    uploader.on('uploadSuccess', function( file, response ) {
        var btnDel = i18nMessage['delete'],
        setThumbnailDel = i18nMessage['gallery.setThumbnail'],
        galleryId = response.galleryId;
        var $div = $('<div style="TEXT-ALIGN: center;">' +
        		'<button type="button" onclick="deleteGallery('+ galleryId +',this)" class="btn btn-danger  mg-auto mg-t-5">'+ btnDel +'</button>' +
        		'<button type="button" onclick="setThumbnail('+ galleryId +',this)" class="btn btn-success  mg-auto mg-t-5 mythumbnail">'+ setThumbnailDel +'</button>'
        		);
        $( '#'+file.id ).append($div);
    });

    // 文件上传失败，现实上传出错。
    uploader.on( 'uploadError', function( file ) {
        var $li = $( '#'+file.id ),
            $error = $li.find('p.error');

        // 避免重复创建
        if ( !$error.length ) {
            $error = $('<p class="error"></p>').appendTo( $li );
        }

        $error.text('上传失败');
    });

    // 完成上传完了，成功或者失败，先删除进度条。
    uploader.on( 'uploadComplete', function( file ) {
    	$( '#'+file.id ).find('.progress').remove();
    });
    
    // 当有文件添加进来时执行，负责view的创建
    function addFile( file ) {
    	var $li = $('<li id="' + file.id + '">' +
	        '<figure>' +
	            '<img src="" alt="img">' +
	            '<figcaption>' +
	                '<h3>Mindblowing</h3>' +
	                '<span>lorem ipsume </span>' +
	                '<a class="fancybox" rel="group" href="">Take a look</a>' +
	            '</figcaption>' +
	        '</figure>' +
	        '<p class="progress"><span></span></p>' +
	    '</li>'),
    	
    	
//        var $li = $( '<li id="' + file.id + '">' +
//                '<p class="title">' + file.name + '</p>' +
//                '<p class="imgWrap"></p>'+
//                '<p class="progress"><span></span></p>' +
//                '</li>' ),

//            $btns = $('<div class="file-panel">' +
//                '<span class="cancel">删除</span>' +
//                '<span class="rotateRight">向右旋转</span>' +
//                '<span class="rotateLeft">向左旋转</span></div>').appendTo( $li ),
            $prgress = $li.find('p.progress span'),
            $wrap = $li.find( 'figure' ),
            $info = $('<p class="error"></p>'),

            showError = function( code ) {
                switch(code) {
                    case 'exceed_size':
                        text = '文件大小超出';
                        break;

                    case 'interrupt':
                        text = '上传暂停';
                        break;

                    default:
                        text = '上传失败，请重试';
                        break;
                }

                $info.text( text ).appendTo( $li );
            };

        if ( file.getStatus() === 'invalid' ) {
            showError( file.statusText );
        } else {
            // @todo lazyload
            //$wrap.text( '预览中' );
            uploader.makeThumb( file, function( error, src ) {
                if ( error ) {
                    $img.replaceWith('<span>不能预览</span>');
                    return;
                }
                $wrap.find('img').attr('src', src);
                $wrap.find('a').attr('href', src);
            }, thumbnailWidth, thumbnailHeight );
            
            percentages[ file.id ] = [ file.size, 0 ];
        }

        file.on('statuschange', function( cur, prev ) {
            if ( prev === 'progress' ) {
                $prgress.hide().width(0);
            } else if ( prev === 'queued' ) {
                $li.off( 'mouseenter mouseleave' );
//                $btns.remove();
            }

            // 成功
            if ( cur === 'error' || cur === 'invalid' ) {
                console.log( file.statusText );
                showError( file.statusText );
                percentages[ file.id ][ 1 ] = 1;
            } else if ( cur === 'interrupt' ) {
                showError( 'interrupt' );
            } else if ( cur === 'queued' ) {
                $info.remove();
                $prgress.css('display', 'block');
                percentages[ file.id ][ 1 ] = 0;
            } else if ( cur === 'progress' ) {
                $info.remove();
                $prgress.css('display', 'block');
            } else if ( cur === 'complete' ) {
                $prgress.hide().width(0);
                $li.append( '<span class="success"></span>' );
            }

            $li.removeClass( 'state-' + prev ).addClass( 'state-' + cur );
        });

//        $li.on( 'mouseenter', function() {
//            $btns.stop().animate({height: 30});
//        });
//
//        $li.on( 'mouseleave', function() {
//            $btns.stop().animate({height: 0});
//        });
//
//        $btns.on( 'click', 'span', function() {
//            var index = $(this).index(),
//                deg;
//
//            switch ( index ) {
//                case 0:
//                    uploader.removeFile( file );
//                    return;
//
//                case 1:
//                    file.rotation += 90;
//                    break;
//
//                case 2:
//                    file.rotation -= 90;
//                    break;
//            }
//
//            if ( supportTransition ) {
//                deg = 'rotate(' + file.rotation + 'deg)';
//                $wrap.css({
//                    '-webkit-transform': deg,
//                    '-mos-transform': deg,
//                    '-o-transform': deg,
//                    'transform': deg
//                });
//            } else {
//                $wrap.css( 'filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation='+ (~~((file.rotation/90)%4 + 4)%4) +')');
//            }
//
//
//        });

        $list.prepend( $li );
    }
    
    function updateTotalProgress() {
        var loaded = 0,
            total = 0,
            spans = $progress.children(),
            percent;

        $.each( percentages, function( k, v ) {
            total += v[ 0 ];
            loaded += v[ 0 ] * v[ 1 ];
        } );

        percent = total ? loaded / total : 0;


        spans.eq( 0 ).text( Math.round( percent * 100 ) + '%' );
        spans.eq( 1 ).css( 'width', Math.round( percent * 100 ) + '%' );
    }
    
});