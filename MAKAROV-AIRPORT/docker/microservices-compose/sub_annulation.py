import asyncio
import nats
import json
import os
import time
import requests
from concurrent.futures import ThreadPoolExecutor

class SubscriberAnnulation():
    def __init__(self, subject, type_) -> None:
        self.nc = None
        self.subject = subject
        self.type_ = type_
        
    def setup(self):
        asyncio.run(self.run_subscriber())

    async def message_handler(self, msg):
        if msg.subject == f"annulation.{self.subject}":
            response_data = await self.annulation(msg)
        else:
            response_data = {"status": "ignore"}
        print("reponse", response_data)
        await msg.respond(json.dumps(response_data).encode())

    async def annulation(self, msg):
        async def get_reservation(numvol, username):
            url = "http://web-rest-3:8003/reservations/infos/"
            headers = {"Content-Type": "application/json"}

            response = requests.get(url, headers=headers)
            reservations = response.json()

            for reservation in reservations:
                if reservation['vol_ref'] == numvol and reservation['user_ref'] == username:
                    return reservation['id']
            return None

        async def put_annulation(numvol, annulation, id):
            url = f"http://web-rest-3:8003/reservations/infos/{id}/"
            headers = {"Content-Type": "application/json"}

            if self.type_ == "annulation" and annulation == "False":
                print(self.type_, annulation)
                data = {"vol_ref": numvol, "demande": "False"}
                response = requests.put(url, headers=headers, data=json.dumps(data))

            data = {"vol_ref": numvol, self.type_: annulation}
            response = requests.put(url, headers=headers, data=json.dumps(data))

        data = json.loads(msg.data.decode())
        numvol = data['numvol']
        annulation = data[self.type_]
        username = data['username']

        id = await get_reservation(numvol, username)
        await put_annulation(numvol, annulation, id)

        return {"status":"True"}
    
    async def run_subscriber(self):
        self.nc = await nats.connect("nats://nats:4222")

        await self.nc.subscribe(f"annulation.{self.subject}", cb=self.message_handler)

        try:
            while True:
                await asyncio.sleep(1)
        except KeyboardInterrupt:
            pass
        finally:
            await self.nc.close()

def main():
    time.sleep(50)
    with ThreadPoolExecutor(max_workers=2) as executor:
        executor.submit(SubscriberAnnulation("demande", "demande").setup)
        executor.submit(SubscriberAnnulation("validation", "annulation").setup)

if __name__ == '__main__':
    main()