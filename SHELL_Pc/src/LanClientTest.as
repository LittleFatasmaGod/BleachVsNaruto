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

package {
import flash.desktop.NativeApplication;
import flash.display.Sprite;
import flash.display.StageDisplayState;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.utils.setTimeout;

import net.play5d.game.bvn.GameQuality;
import net.play5d.game.bvn.MainGame;
import net.play5d.game.bvn.data.GameData;
import net.play5d.game.bvn.data.GameMode;
import net.play5d.game.bvn.debug.Debugger;
import net.play5d.game.bvn.interfaces.GameInterface;
import net.play5d.game.bvn.ui.GameUI;
import net.play5d.game.bvn.utils.GameLogger;
import net.play5d.game.bvn.utils.URL;
import net.play5d.game.bvn.win.GameInterfaceManager;
import net.play5d.game.bvn.win.ctrls.LANClientCtrl;
import net.play5d.game.bvn.win.ctrls.LANGameCtrl;
import net.play5d.game.bvn.win.data.HostVO;
import net.play5d.game.bvn.win.utils.Loger;
import net.play5d.game.bvn.win.utils.UIAssetUtil;

[SWF(width='800', height='600', frameRate='30', backgroundColor='#000000')]
public class LanClientTest extends Sprite {
    public function LanClientTest() {
        if (stage) {
            initlize();
        }
        else {
            addEventListener(Event.ADDED_TO_STAGE, initlize);
        }
    }
    private var _mainGame:MainGame;

    private function buildGame():void {

        GameLogger.log('buildGame');

        _mainGame = new MainGame();
        _mainGame.initlize(this, stage, initBackHandler, initFailHandler);
        if (Debugger.DEBUG_ENABLED) {
            Debugger.initDebug(stage);
        }

    }

    private function initBackHandler():void {

        GameLogger.log('init ok');

        UIAssetUtil.I.initalize(testClient);
        //			_mainGame.goMenu();
        //			_mainGame.goCongratulations();
    }

    private function initFailHandler(msg:String):void {
        GameLogger.log('init fail');
    }

    private function setWindowTemp():void {
        setTimeout(function ():void {
//				NativeApplication.nativeApplication.activeWindow.width = 400;
//				NativeApplication.nativeApplication.activeWindow.height = 300;
//				NativeApplication.nativeApplication.activeWindow.x = 10;
//				NativeApplication.nativeApplication.activeWindow.y = 200;

            NativeApplication.nativeApplication.activeWindow.width  = 800;
            NativeApplication.nativeApplication.activeWindow.height = 600;
            NativeApplication.nativeApplication.activeWindow.x      = 1000;
            NativeApplication.nativeApplication.activeWindow.y      = 100;

        }, 200);
    }

    private function testClient():void {
        var host:HostVO = new HostVO();
        host.ip         = '127.0.0.1';
        host.tcpPort    = LANGameCtrl.PORT_TCP;
        host.udpPort    = LANGameCtrl.PORT_UDP_SERVER;
        LANClientCtrl.I.initlize();
        LANClientCtrl.I.join(host, joinBack);
    }

    private function joinBack(succ:Boolean, msg:String):void {
        if (!succ) {
            return;
        }
        LANClientCtrl.I.gameStart();
        GameMode.currentMode = GameMode.TEAM_VS_PEOPLE;
        MainGame.I.goSelect();
    }

    private function initlize(e:Event = null):void {

        GameLogger.setLoger(new Loger());

        GameLogger.log('init...');

        removeEventListener(Event.ADDED_TO_STAGE, initlize);

        GameInterface.instance = new GameInterfaceManager();

        GameInterfaceManager.config.isFullScreen = false;

//			if(GameInterfaceManager.config.isFullScreen){
//				stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
//			}

        GameUI.BITMAP_UI = true;

        GameData.I.config.AI_level     = 1;
        GameData.I.config.quality      = GameQuality.MEDIUM;
        GameData.I.config.keyInputMode = 0;

        URL.MARK = 'bvn_win' + MainGame.VERSION;

        buildGame();

        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);

        setWindowTemp();

    }

    private function keyDownHandler(e:KeyboardEvent):void {
        if (e.keyCode == Keyboard.ESCAPE) {
            e.preventDefault();
        }
        if (e.keyCode == Keyboard.F11) {
            if (stage.displayState == StageDisplayState.NORMAL) {
                stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
            }
            else {
                stage.displayState = StageDisplayState.NORMAL;
            }
        }
    }

}
}
