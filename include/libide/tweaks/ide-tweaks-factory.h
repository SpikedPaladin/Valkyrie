/* ide-tweaks-factory.h
 *
 * Copyright 2022 Christian Hergert <chergert@redhat.com>
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
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

#pragma once

#include "ide-tweaks-item.h"

G_BEGIN_DECLS

#define IDE_TYPE_TWEAKS_FACTORY (ide_tweaks_factory_get_type())

IDE_AVAILABLE_IN_ALL
G_DECLARE_FINAL_TYPE (IdeTweaksFactory, ide_tweaks_factory, IDE, TWEAKS_FACTORY, IdeTweaksItem)

IDE_AVAILABLE_IN_ALL
IdeTweaksFactory *ide_tweaks_factory_new       (void);
IDE_AVAILABLE_IN_ALL
GListModel       *ide_tweaks_factory_get_model (IdeTweaksFactory     *self);
IDE_AVAILABLE_IN_ALL
void              ide_tweaks_factory_set_model (IdeTweaksFactory     *self,
                                                GListModel           *model);
IDE_AVAILABLE_IN_ALL
gpointer          ide_tweaks_factory_get_item  (IdeTweaksFactory     *self);
IDE_AVAILABLE_IN_ALL
gboolean          ide_tweaks_factory_visit     (IdeTweaksFactory     *self,
                                                IdeTweaksItemVisitor  visitor,
                                                gpointer              visitor_data);

G_END_DECLS
