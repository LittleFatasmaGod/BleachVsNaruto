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

package net.play5d.game.bvn.utils {
import flash.display.DisplayObject;
import flash.display.FrameLabel;
import flash.display.MovieClip;
import flash.filters.ColorMatrixFilter;

import net.play5d.game.bvn.ctrler.game_ctrls.GameCtrl;

import net.play5d.game.bvn.interfaces.IGameSprite;
import net.play5d.game.bvn.stage.GameStage;

/**
 * 影片剪辑实用工具
 */
public class MCUtils {
    include '../../../../../../include/_INCLUDE_.as';

    /**
     * 影片剪辑是否具有指定名称帧
     *
     * @param mc 指定影片剪辑
     * @param label 帧名称
     *
     * @return 影片剪辑是否具有某个帧
     */
    public static function hasFrameLabel(mc:MovieClip, label:String):Boolean {
        var labels:Array = mc.currentLabels;

        for each(var i:FrameLabel in labels) {
            if (i.name == label) {
                return true;
            }
        }

        return false;
    }

    /**
     * 设置显示对象色相滤镜（-180 - 180）
     *
     * @param display
     * @param hue 色相值（-180 - 180）
     *
     */
    public static function setHue(display:DisplayObject, hue:Number = 0):void {
        if (hue == 0) {
            display.filters = null;

            return;
        }

        var filter:ColorMatrixFilter = createHueFilter(hue);
        display.filters              = [filter];
    }

    /**
     * 创建一个色相滤镜
     *
     * @param n 色相值（-180 - 180）
     *
     * @return 创建完成一个色相滤镜
     */
    private static function createHueFilter(n:Number):ColorMatrixFilter {
        const p1:Number = Math.cos(n * Math.PI / 180);
        const p2:Number = Math.sin(n * Math.PI / 180);
        const p4:Number = 0.213;
        const p5:Number = 0.715;
        const p6:Number = 0.072;

        const matrix:Array = [
            p4 + p1 * (1 - p4) + p2 * (0 - p4),
            p5 + p1 * (0 - p5) + p2 * (0 - p5),
            p6 + p1 * (0 - p6) + p2 * (1 - p6),
            0,
            0,
            p4 + p1 * (0 - p4) + p2 * 0.143,
            p5 + p1 * (1 - p5) + p2 * 0.14,
            p6 + p1 * (0 - p6) + p2 * -0.283,
            0,
            0,
            p4 + p1 * (0 - p4) + p2 * (0 - (1 - p4)),
            p5 + p1 * (0 - p5) + p2 * p5,
            p6 + p1 * (1 - p6) + p2 * p6,
            0,
            0,
            0,
            0,
            0,
            1,
            0
        ];

        return new ColorMatrixFilter(matrix);
    }

    /**
     * 停止指定影片剪辑以及其子影片剪辑的播放
     *
     * @param mc 指定影片剪辑
     */
    public static function stopAllMovieClips(mc:MovieClip):void {
        for(var i:int = 0; i < mc.numChildren; i++) {
            var d:DisplayObject = mc.getChildAt(i);

            if (d && d is MovieClip){
                var m:MovieClip = d as MovieClip;

                m.stop();
                stopAllMovieClips(m);
            }
        }
    }

    /**
     * 使用回调方式渲染游戏元件
     *
     * @param back 回调函数，需要一个参数 sp，类型为 IGameSprite
     */
    public static function renderGameSpritesCB(back:Function):void {
        var gameStage:GameStage = GameCtrl.I.gameState;
        if (!gameStage) {
            return;
        }

        var gameSprites:Vector.<IGameSprite> = gameStage.getGameSprites();
        if (!gameSprites || gameSprites.length == 0) {
            return;
        }

        for (var i:int = 0; i < gameSprites.length; i++) {
            var sp:IGameSprite = gameSprites[i] as IGameSprite;

            if (back != null) {
                back(sp);
            }

            if (!sp || sp.isDestoryed()) {
                i--;
            }
        }
    }
}
}
