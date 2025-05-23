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

package net.play5d.game.bvn.win.utils {
public class JsonUtils {
    public static function isJsonString(v:Object):Boolean {
        if (v is String) {
            var vs:String = v as String;
            return vs.charAt(0) == '{' || vs.charAt(0) == '[';
        }
        return false;
    }

    public static function str2json(v:Object):Object {
        if (isJsonString(v)) {
            var obj:Object;
            try {
                obj = JSON.parse(v as String);
            }
            catch (e:Error) {
                trace(e);
            }
            return obj;
        }
        return null;
    }

    public function JsonUtils() {
    }

}
}
