package net.play5d.game.bvn.mob.utils {
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.utils.ByteArray;

public class FileUtils {
    /**
     * 写文件（如果文件不存在将新建，如果存在则替换）
     * @param url 完整路径（C:\abc）
     * @param content 文件数据,支持String,ByteArray
     */
    public static function writeFile(url:String, content:*, fileMode:String = null):void {
        fileMode ||= FileMode.WRITE;

        try {
            var file:File     = new File(url);
            var fs:FileStream = new FileStream();
            fs.open(file, fileMode);

            if (content is String) {
                fs.writeUTFBytes(content);
            }
            if (content is ByteArray) {
                var byte:ByteArray = (
                        content as ByteArray
                );
                fs.writeBytes(byte, 0, byte.bytesAvailable);
            }

            fs.close();
        }
        catch (e:Error) {
            trace('FileUtils.writeFile', e);
        }
    }

    /**
     * 写主程序目录下的文件（如果文件不存在将新建，如果存在则替换）
     * @param nativeUrl 相对路径（abc/123/1.txt）
     * @param content 文件数据,支持String,ByteArray
     */
    public static function writeAppFloderFile(nativeUrl:String, content:*, fileMode:String = null):void {
        var url:String = getAppFloderFileUrl(nativeUrl);
        writeFile(url, content, fileMode);
    }

    public static function getAppFloderFileUrl(nativeUrl:String):String {
        var path:File      = File.applicationDirectory;
        var pathUrl:String = path.nativePath;
        var url:String     = pathUrl + '/' + nativeUrl;
        return url;
    }

    /**
     * 创建目录
     * @param url 完整路径（C:\abc）
     */
    public static function createFloder(url:String):void {
        try {
            var dir:File = new File(url);
            dir.createDirectory();
        }
        catch (e:Error) {
            trace('FileUtils.createFloder', e);
        }
    }

    public static function readTextFile(url:String):String {
        var text:String;
        try {
            var file:File     = new File(url);
            var fs:FileStream = new FileStream();
            fs.open(file, FileMode.READ);
            text = fs.readUTFBytes(fs.bytesAvailable);
            fs.close();
        }
        catch (e:Error) {
            trace('FileUtils.readTextFile', url, e);
        }
        return text;
    }

    public static function del(url:String):void {
        var file:File = new File(url);
        try {
            file.deleteFile();
        }
        catch (e:Error) {
            trace('FileUtils.del', e);
        }

    }

    public function FileUtils() {
    }

}
}
