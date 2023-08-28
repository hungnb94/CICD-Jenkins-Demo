import 'dotenv/config';
import {Browser, RemoteOptions} from "webdriverio";
import {DesiredCapabilities} from "@wdio/types/build/Capabilities";

const APP_PACKAGE = "com.example.test123";

export const SECOND_IN_MS = 1000;
export const DEFAULT_TIMEOUT = 10 * SECOND_IN_MS;

const androidCaps: DesiredCapabilities = {
    platformName: 'Android',
    automationName: 'UiAutomator2',
    // udid: process.env.DEVICE_UUID,
    appPackage: APP_PACKAGE,
    appActivity: `${APP_PACKAGE}.MainActivity`,
};

export const androidOptions: RemoteOptions = {
    capabilities: androidCaps,
    path: '/wd/hub',
    hostname: process.env.APPIUM_HOST || 'host.docker.internal',
    port: Number(process.env.APPIUM_PORT) || 4723,
    logLevel: 'info'
}

export function idOf(componentId: string) {
    return `id=${APP_PACKAGE}:id/${componentId}`;
}

export async function getApiLevel(client: Browser<'async'>): Promise<number> {
    return await client.executeScript('mobile: shell', [{'command': 'getprop', args: ['ro.build.version.sdk']}]);
}

export async function waitForTextExist(client: Browser<'async'>, questionTextFragment: string) {
    const questionSelector = `new UiSelector().textContains("${questionTextFragment}").className("android.widget.TextView")`;
    const question = await client.$(`android=${questionSelector}`);
    await question.waitForExist({ timeout: DEFAULT_TIMEOUT });
}
