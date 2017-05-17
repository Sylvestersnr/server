#ifndef MAPSOCKET_H
#define MAPSOCKET_H

#include "MangosSocket.h"
#include "Auth/AuthCrypt.h"
#include <memory>

class NodeSession;
template <typename T>
class ReactorRunnable;
template <typename T>
class MangosSocketMgr;

class MapSocket: public MangosSocket<NodeSession, MapSocket, NoCrypt>
{
    friend class MangosSocket<NodeSession, MapSocket, NoCrypt>;
    friend class MangosSocketMgr<MapSocket>;
    friend class ReactorRunnable<MapSocket>;
    public:
        int SendStartupPacket();
    protected:
        int OnSocketOpen();
        int ProcessIncoming (std::unique_ptr<WorldPacket> new_pct);
        int iSendPacket (const WorldPacket& pct);
};

#endif // MAPSOCKET_H
