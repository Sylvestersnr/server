/*
 * Copyright (C) 2005-2011 MaNGOS <http://getmangos.com/>
 * Copyright (C) 2009-2011 MaNGOSZero <https://github.com/mangos/zero>
 * Copyright (C) 2011-2016 Nostalrius <https://nostalrius.org>
 * Copyright (C) 2016-2017 Elysium Project <https://github.com/elysium-project>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#ifndef LOCKEDQUEUE_H
#define LOCKEDQUEUE_H

#include <assert.h>
#include "Errors.h"
#include <deque>
#include <mutex>
#include <memory>

class WorldPacket;

template <class T>
class LockedQueue
{
    //! Lock access to the queue.
    std::mutex _lock;

    //! Storage backing the queue.
    std::queue<T> _queue;

    //! Cancellation flag.
    /*volatile*/ bool _canceled;

    public:

        //! Create a LockedQueue.
        LockedQueue()
            : _canceled(false)
        {
        }

        //! Destroy a LockedQueue.
        virtual ~LockedQueue()
        {
        }

        //! Adds an item to the queue.
        void add(T item)
        {
            std::lock_guard<std::mutex> g(_lock);
            _queue.emplace(std::move(item));
        }

        T clear()
        {
            _queue = {};
        }

        T front()
        {
            return std::move(_queue.front());
        }

        void pop_front()
        {
            _queue.pop_front();
        }

        //! Gets the next result in the queue, if any.
        bool next(T* result, int hack)
        {
            std::lock_guard<std::mutex> g(_lock);

            if (_queue.empty())
                return false;

            *result = std::move(_queue.front());
            _queue.pop();

            return true;
        }

        template<class Checker>
        bool next(T* result, Checker& check, int hack) // this is as bad as you think it is
        {
            std::lock_guard<std::mutex> g(_lock);

            if (_queue.empty())
                return false;

            *result = std::move(_queue.front());
            _queue.pop();

            if (!check.Process((*result).get()))
            {
                //_queue.(std::move(*result));
                return false;
            }

       
            return true;
        }

        //! Gets the next result in the queue, if any.
        bool next(T& result)
        {
            std::lock_guard<std::mutex> g(_lock);

            if (_queue.empty())
                return false;

            result = std::move(_queue.front());
            _queue.pop();

            return true;
        }

        template<class Checker>
        bool next(T& result, Checker& check)
        {
            std::lock_guard<std::mutex> g(_lock);

            if (_queue.empty())
                return false;

            result = _queue.front();
            if(!check.Process(result))
                return false;

            _queue.pop();
            return true;
        }

        //! Peeks at the top of the queue. Remember to unlock after use.
        T& peek()
        {
            lock();

            T& result = _queue.front();

            return result;
        }

        //! Cancels the queue.
        void cancel()
        {
            std::lock_guard<std::mutex> g(_lock);
            _canceled = true;
        }

        //! Checks if the queue is cancelled.
        bool cancelled()
        {
            std::lock_guard<std::mutex> g(_lock);
            return _canceled;
        }

        //! Locks the queue for access.
        void lock()
        {
            _lock.lock();
        }

        //! Unlocks the queue.
        void unlock()
        {
            _lock.unlock();
        }

        bool empty()
        {
            std::lock_guard<std::mutex> g(_lock);
            return _queue.empty();
        }
};
#endif
