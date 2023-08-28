import { describe } from "mocha";
import { remote, Browser } from "webdriverio";
import { androidOptions } from "../helpers/test_utils";

describe('Home screen', function () {

    let client: Browser<'async'>;

    beforeEach(async function () {
        client = await remote(androidOptions);
    })

    afterEach(async function () {
        await client.deleteSession();
    })

    it('should show button send', async function () {
        const buttonSend = await client.$('android=new UiSelector().text("SEND")');
        await buttonSend.click();
    });

});
