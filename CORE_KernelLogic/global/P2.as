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
import net.play5d.game.bvn.ctrler.game_ctrls.GameCtrl;
import net.play5d.game.bvn.data.vos.GameRunDataVO;
import net.play5d.game.bvn.fighter.FighterMain;

/**
 * 获取 P2 引用
 * @return P2 引用
 */
public function get P2():FighterMain {
    var runData:GameRunDataVO = GameCtrl.I.gameRunData;
    if (!runData) {
        return null;
    }

    var p2:FighterMain = runData.p2FighterGroup.currentFighter;
    return p2;
}
}
