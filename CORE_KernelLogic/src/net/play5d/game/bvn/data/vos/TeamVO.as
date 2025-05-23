/*
 * Copyright (C) 2021-2025, 5DPLAY Game Studio
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

package net.play5d.game.bvn.data.vos {
import net.play5d.game.bvn.interfaces.BaseGameSprite;
import net.play5d.game.bvn.interfaces.IGameSprite;
import net.play5d.game.bvn.interfaces.IInstanceVO;

public class TeamVO implements IInstanceVO {
    include '../../../../../../../include/_INCLUDE_.as';
    include '../../../../../../../include/Clone.as';

    public function TeamVO(id:int, name:String = null) {
        this.id   = id;
        this.name = name;
    }

    public var id:int;
    public var name:String;
    public var children:Vector.<IGameSprite> = new Vector.<IGameSprite>();

    public function getAliveChildren():Vector.<IGameSprite> {
        var result:Vector.<IGameSprite> = new Vector.<IGameSprite>();
        for (var i:int; i < children.length; i++) {
            var c:IGameSprite = children[i];
            if (c is BaseGameSprite) {
                if ((
                        c as BaseGameSprite
                ).isAlive) {
                    result.push(c);
                }
            }
            else {
                result.push(c);
            }
        }
        return result;
    }

    public function addChild(v:IGameSprite):void {
        var index:int = children.indexOf(v);
        if (index == -1) {
            children.push(v);
        }
    }

    public function removeChild(v:IGameSprite):void {
        var index:int = children.indexOf(v);
        if (index != -1) {
            children.splice(index, 1);
        }
    }

}
}
