/*
 * Copyright (C) 2021-2024, 5DPLAY Game Studio
 * All rights reserved.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package net.play5d.game.bvn.win {
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.media.Sound;
import flash.net.URLRequest;

import net.play5d.game.bvn.interfaces.IAssetLoader;
import net.play5d.kyo.loader.KyoLoaderLite;
import net.play5d.kyo.loader.KyoURLoader;

public class AssetLoader implements IAssetLoader {

    public function AssetLoader() {
    }

    public function loadXML(url:String, back:Function, fail:Function = null):void {
        url = getFullUrl(url);

        KyoURLoader.load(url, function (data:String):void {
            back(new XML(data));
        }, fail);
    }

    public function loadJSON(url:String, back:Function, fail:Function = null):void {
        url = getFullUrl(url);

        KyoURLoader.load(url, function (data:String):void {
            try {
                var json:Object = JSON.parse(data);
                back(json);
            }
            catch (e:Error) {
                trace(e);
                if (fail != null) {
                    fail();
                }
            }

        }, fail);
    }

    public function loadSwf(url:String, back:Function, fail:Function = null, process:Function = null):void {
        url = getFullUrl(url);
        KyoLoaderLite.loadLoader(url, back, fail, process);
    }

    public function loadBitmap(url:String, back:Function, fail:Function = null, process:Function = null):void {
        url = getFullUrl(url);
        KyoLoaderLite.load(url, back, fail, process);

    }

    public function loadSound(url:String, back:Function, fail:Function = null, process:Function = null):void {
        url = getFullUrl(url);

        var s:Sound = new Sound();
        s.addEventListener(Event.COMPLETE, onComplete);
        s.addEventListener(IOErrorEvent.IO_ERROR, onError);
        s.addEventListener(ProgressEvent.PROGRESS, onProgress);

        s.load(new URLRequest(url));

        function clear():void {
            s.removeEventListener(Event.COMPLETE, onComplete);
            s.removeEventListener(IOErrorEvent.IO_ERROR, onError);
            s.removeEventListener(ProgressEvent.PROGRESS, onProgress);
        }

        function onComplete(e:Event):void {
            back(s);
            clear();
        }

        function onError(e:IOErrorEvent):void {
            if (fail != null) {
                fail();
            }
            clear();
        }

        function onProgress(e:ProgressEvent):void {
            if (process != null) {
                process(e.bytesLoaded / e.bytesTotal);
            }
        }


        //			loadAssetBytes(url, function(v:ByteArray):void{
        //				var s:BytesSound = new BytesSound(v);
        //				if(back != null) back(s);
        //			}, fail, process);

    }

    public function dispose(url:String):void {
    }

    public function needPreLoad():Boolean {
        return false;
    }

    public function loadPreLoad(back:Function, fail:Function = null, process:Function = null):void {

    }

    private function getFullUrl(url:String):String {
        return 'assets/' + url;
    }

    //		private function loadAssetBytes(url:String, back:Function, fail:Function, process:Function = null):void{
    ////			KyoLoaderLite.loadBytes("ALL MAN/assets/" + url , back , fail, process);
    //			KyoLoaderLite.loadBytes("assets/" + url , back , fail, process);
    ////			KyoLoaderLite.loadBytes(url , back , fail, process);
    //		}


}
}
