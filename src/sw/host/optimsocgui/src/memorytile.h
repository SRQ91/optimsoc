/**
 * This file is part of OpTiMSoC-GUI.
 *
 * OpTiMSoC-GUI is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation, either version 3 of
 * the License, or (at your option) any later version.
 *
 * OpTiMSoC-GUI is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with OpTiMSoC. If not, see <http://www.gnu.org/licenses/>.
 *
 * =================================================================
 *
 * Driver for the simple message passing hardware.
 *
 * (c) 2012-2013 by the author(s)
 *
 * Author(s):
 *    Philipp Wagner, philipp.wagner@tum.de
 */

#ifndef MEMORYTILE_H
#define MEMORYTILE_H

#include <QByteArray>

#include "tile.h"

class MemoryTileItem;

class MemoryTile : public Tile
{
Q_OBJECT
public:
    explicit MemoryTile(int memoryTileId, QObject *parent = 0);
    QString tileTypeName() const { return tr("memory tile"); };

    TileItem* componentItem();

    bool initMemory(QByteArray data);

signals:
    void memoryWriteFinished(bool success);

public slots:

protected:
    int m_memoryTileId;

};

#endif // MEMORYTILE_H