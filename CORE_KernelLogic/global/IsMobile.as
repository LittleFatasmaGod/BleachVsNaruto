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
import net.play5d.game.bvn.GameConfig;

/**
 * 全局函数，判断当前运行版本是否为 <b>移动端</b> <br>
 * 当 <code>GameConfig.TOUCH_MODE</code> 为 <code>true</code> 时，
 * 当前版本为 <b>移动端</b>。
 * <p/>
 * 下列代码演示如何使用全局方法 <code>IsMobile()</code> 进行判断版本：
 * <listing version="3.0">
 var isMobile:Boolean = IsMobile();
 trace(isMobile);
 * </listing>
 *
 * @see           Boolean
 * @return        若当前运行版本为 <b>移动端</b>，返回 <code>true</code>，否则返回 <code>false</code>
 *
 * @langversion   3.0
 * @playerversion Flash 9, Lite 4
 */
public function IsMobile():Boolean {
    return GameConfig.TOUCH_MODE;
}
}
