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

package net.play5d.game.bvn.data.musou {
import net.play5d.game.bvn.interfaces.IInstanceVO;

public class MusouMissionVO implements IInstanceVO {
    include '../../../../../../../include/_INCLUDE_.as';
    include '../../../../../../../include/Clone.as';

    public function MusouMissionVO() {
    }
    public var id:String;
    /**
     * 名称
     */
    public var name:String;
    /**
     * 地图 (mapID)
     */
    public var map:String;
    /**
     * 关卡时间（秒）
     */
    public var time:int;
    /**
     * 敌人等级
     */
    public var enemyLevel:int;
    /**
     * 波次
     */
    public var waves:Vector.<MusouWaveVO>;
    public var area:MusouWorldMapAreaVO;

//		public function initByXML(xml:XML):void{
//
//			map = xml.@map;
//			time = int(xml.@time);
//			if(time < 1){
//				throw new Error("init mousou stage error!");
//			}
//			waves = new Vector.<MusouWaveVO>();
//
//			for each(var i:XML in xml.wave){
//				var wave:MusouWaveVO = MusouWaveVO.createByXML(i);
//				addWave(wave);
//			}
//		}

    public function initByJsonObject(o:Object):void {
        id         = o.id;
        map        = o.map;
        time       = int(o.time);
        enemyLevel = int(o.enemyLevel);

        if (enemyLevel < 1) {
            enemyLevel = 1;
        }

        if (!map || time < 1) {
            throw new Error(GetLang('debug.error.data.musou_mission_vo.init_musou_stage_fail'));
        }

        var wvs:Array = o.waves;

        waves = new Vector.<MusouWaveVO>();

        for (var i:int; i < wvs.length; i++) {
            var wave:MusouWaveVO = MusouWaveVO.createByJSON(wvs[i]);
            addWave(wave);
        }
    }

    public function getAllEnemies():Vector.<MusouEnemyVO> {
        var result:Vector.<MusouEnemyVO> = new Vector.<MusouEnemyVO>();
        for (var i:int; i < waves.length; i++) {
            var w:MusouWaveVO                 = waves[i];
            var enemies:Vector.<MusouEnemyVO> = w.getAllEnemies();
            if (enemies) {
                result = result.concat(enemies);
            }
        }
        return result;
    }

    public function getAllEnemieIds():Array {
        var result:Array = [];
        for (var i:int; i < waves.length; i++) {
            var w:MusouWaveVO   = waves[i];
            var enemieIds:Array = w.getAllEnemieIds();
            if (enemieIds) {
                for each(var e:String in enemieIds) {
                    if (result.indexOf(e) == -1) {
                        result.push(e);
                    }
                }
            }
        }
        return result;
    }

    public function getBossIds():Array {
        var bosses:Vector.<MusouEnemyVO> = getBosses();
        var result:Array                 = [];
        for each(var i:MusouEnemyVO in bosses) {
            if (result.indexOf(i.fighterID) == -1) {
                result.push(i.fighterID);
            }
        }
        return result;
    }

    public function getBosses():Vector.<MusouEnemyVO> {
        var result:Vector.<MusouEnemyVO> = new Vector.<MusouEnemyVO>();
        for (var i:int; i < waves.length; i++) {
            var w:MusouWaveVO                = waves[i];
            var bosses:Vector.<MusouEnemyVO> = w.getBosses();
            if (bosses) {
                for each(var e:MusouEnemyVO in bosses) {
                    if (result.indexOf(e) == -1) {
                        result.push(e);
                    }
                }
            }
        }
        return result;
    }

    public function addWave(wave:MusouWaveVO):void {
        waves ||= new Vector.<MusouWaveVO>();
        wave.id = waves.length + 1;
        waves.push(wave);
    }

    public function bossCount():int {
        var count:int;
        for (var i:int; i < waves.length; i++) {
            var w:MusouWaveVO = waves[i];
            count += w.bossCount();
        }
        return count;
    }

}
}
