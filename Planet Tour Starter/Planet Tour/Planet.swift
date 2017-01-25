/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

public struct Planet {

  // MARK: - Properties
  public let name: String
  public let yearInDays: Double
  public let massInEarths: Double
  public let radiusInEarths: Double
  public let funFact: String
  public let image: UIImage
  public let imageCredit: String

  // MARK: - Initializers
  public init(name: String, yearInDays: Double, massInEarths: Double, radiusInEarths: Double, funFact: String, imageName: String, imageCredit: String) {
    self.name = name
    self.yearInDays = yearInDays
    self.massInEarths = massInEarths
    self.radiusInEarths = radiusInEarths
    self.funFact = funFact
    self.image = UIImage(named: imageName)!
    self.imageCredit = imageCredit
  }
}
