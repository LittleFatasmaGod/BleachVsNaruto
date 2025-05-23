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

package net.play5d.game.bvn.interfaces {
import flash.utils.ByteArray;

public class GameInterface {
    include '../../../../../../include/_INCLUDE_.as';

//		private static var _i:GameInterface;
//		public static function get I():GameInterface{
//			_i ||= new GameInterface();
//			return _i;
//		}

    public static var instance:IGameInterface;

    public static function getDefaultMenu():Array {
        var a:Array = [

            {
                txt: 'TEAM PLAY', cn: GetLang('txt.game_interface.team_play'), children: [
                    {txt: 'TEAM ACRADE', cn: GetLang('txt.game_interface.team_play_acrade')},
                    {txt: 'TEAM VS PEOPLE', cn: GetLang('txt.game_interface.team_play_vs_people')},
                    {txt: 'TEAM VS CPU', cn: GetLang('txt.game_interface.team_play_vs_CPU')},
                    {txt: 'TEAM WATCH', cn: GetLang('txt.game_interface.team_play_watch')}
                ]
            },

            {
                txt: 'SINGLE PLAY', cn: GetLang('txt.game_interface.single_play'), children: [
                    {txt: 'SINGLE ACRADE', cn: GetLang('txt.game_interface.single_play_acrade')},
                    {txt: 'SINGLE VS PEOPLE', cn: GetLang('txt.game_interface.single_play_vs_people')},
                    {txt: 'SINGLE VS CPU', cn: GetLang('txt.game_interface.single_play_vs_CPU')},
                    {txt: 'SINGLE WATCH', cn: GetLang('txt.game_interface.single_play_watch')}
                ]
            },

            {
                txt: 'MUSOU PLAY', cn: GetLang('txt.game_interface.musou_play'), children: [
                    {txt: 'MUSOU ACRADE', cn: GetLang('txt.game_interface.musou_acrade')}
                ]
            },

            {txt: 'OPTION', cn: GetLang('txt.game_interface.option')},
            {txt: 'TRAINING', cn: GetLang('txt.game_interface.training')},
            {txt: 'CREDITS', cn: GetLang('txt.game_interface.credits')},
//            {txt: 'MORE GAMES', cn: GetLang('txt.game_interface.more_games')}
        ];
        return a;
    }

    public static function checkFile(url:String, file:ByteArray):Boolean {
        if (instance) {
            return instance.checkFile(url, file);
        }
        return true;
    }

    public static function addMoney(back:Function):void {
        function addMoneyBack(money:*):void {
            var mm:int = int(money);
            if (mm < 1) {
                return;
            }
            if (mm > 5000) {
                return;
            }
            back(mm);
        }

        if (instance) {
            instance.addMusouMoney(addMoneyBack);
            return;
        }
        addMoneyBack(100 + Math.random() * 500);
    }

    public function GameInterface() {
    }

//		public var moreGames:Function;
//		public var


}
}
