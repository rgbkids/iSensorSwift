//
//  AudioViewController.swift
//  iSensorSwift
//
//  Created by koogawa on 2016/04/15.
//  Copyright © 2016 koogawa. All rights reserved.
//

import UIKit
import AudioToolbox

private func AudioQueueInputCallback(
    inUserData: UnsafeMutablePointer<Void>,
    inAQ: AudioQueueRef,
    inBuffer: AudioQueueBufferRef,
    inStartTime: UnsafePointer<AudioTimeStamp>,
    inNumberPacketDescriptions: UInt32,
    inPacketDescs: UnsafePointer<AudioStreamPacketDescription>)
{
    // Do nothing, because not recoding.
}

class AudioViewController: UIViewController {

    var queue: AudioQueueRef!
    var timer: NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.startUpdatingVolume()
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.stopUpdatingVolume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Internal methods

    func startUpdatingVolume() {
        // Set data format
        var dataFormat = AudioStreamBasicDescription(
            mSampleRate: 44100.0,
            mFormatID: kAudioFormatLinearPCM,
            mFormatFlags: AudioFormatFlags(kLinearPCMFormatFlagIsBigEndian | kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked),
            mBytesPerPacket: 2,
            mFramesPerPacket: 1,
            mBytesPerFrame: 2,
            mChannelsPerFrame: 1,
            mBitsPerChannel: 16,
            mReserved: 0)

        // Observe input level
        var audioQueue: AudioQueueRef = nil
        var error = noErr
        error = AudioQueueNewInput(
            &dataFormat,
            AudioQueueInputCallback,
            UnsafeMutablePointer(unsafeAddressOf(self)),
            .None,
            .None,
            0,
            &audioQueue)
        if error == noErr {
            self.queue = audioQueue
        }
        AudioQueueStart(self.queue, nil)

        // Enable level meter
        var enabledLevelMeter: UInt32 = 1
        AudioQueueSetProperty(self.queue, kAudioQueueProperty_EnableLevelMetering, &enabledLevelMeter, UInt32(sizeof(UInt32)))

        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.5,
                                                            target: self,
                                                            selector: #selector(AudioViewController.detectVolume(_:)),
                                                            userInfo: nil,
                                                            repeats: true)
        self.timer?.fire()
    }

    func stopUpdatingVolume()
    {
        // Finish observation
        self.timer.invalidate()
        self.timer = nil
        AudioQueueFlush(self.queue)
        AudioQueueStop(self.queue, false)
        AudioQueueDispose(self.queue, true)
    }

    func detectVolume(timer: NSTimer)
    {
        // Get level
        var levelMeter = AudioQueueLevelMeterState()
        var propertySize = UInt32(sizeof(AudioQueueLevelMeterState))

        AudioQueueGetProperty(
            self.queue,
            kAudioQueueProperty_CurrentLevelMeterDB,
            &levelMeter,
            &propertySize)

        print(levelMeter.mPeakPower)
        print(levelMeter.mAveragePower)
//        self.peakTextField.text = [NSString stringWithFormat:@"%.2f", levelMeter.mPeakPower];
//        self.averageTextField.text = [NSString stringWithFormat:@"%.2f", levelMeter.mAveragePower];

        // Show "LOUD!!" if mPeakPower is larger than -1.0
//        self.loudLabel.hidden = (levelMeter.mPeakPower >= -1.0f) ? NO : YES;
    }
}
