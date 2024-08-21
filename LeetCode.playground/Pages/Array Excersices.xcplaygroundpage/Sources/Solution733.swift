import Foundation

public class Solution733 {
    public static func floodFill(_ matrixArray: [[Int]], _ row: Int, _ col: Int, _ color: Int) -> [[Int]] {
        guard validateIsPositionIsAllowed(row, col, matrixArray) else {
            return matrixArray
        }

        let targetValue = matrixArray[row][col]
        let newCache = Cache()
        propagate(pixel: (row, col), matrix: matrixArray, cache: newCache, targetValue: targetValue)
        let matrix = Matrix(values: matrixArray)
        newCache.update(matrix, with: color)

        return matrix.values
    }

    static func propagate(pixel: (row: Int, col: Int), matrix: [[Int]], cache: Cache, targetValue: Int) {
        let (row, col) = pixel

        guard validateIsPositionIsAllowed(row, col, matrix) else {
            return
        }

        guard matrix[row][col] == targetValue else {
            return
        }

        let targetPixel = Point(row: row, col: col)
        
        guard !cache.exists(point: targetPixel) else {
            return
        }

        cache.save(point: targetPixel)

        let upIndexes = (row: row - 1, col: col)
        propagate(pixel: upIndexes, matrix: matrix, cache: cache, targetValue: targetValue)
        
        let rightIndexes = (row: row, col: col + 1)
        propagate(pixel: rightIndexes, matrix: matrix, cache: cache, targetValue: targetValue)

        let downIndexes = (row: row + 1, col: col)
        propagate(pixel: downIndexes, matrix: matrix, cache: cache, targetValue: targetValue)
        
        let leftIndexes = (row: row, col: col - 1)
        propagate(pixel: leftIndexes, matrix: matrix, cache: cache, targetValue: targetValue)
    }
}

func validateIsPositionIsAllowed(_ row: Int, _ col: Int, _ matrix: [[Int]]) -> Bool {
    guard row >= 0, row < matrix.count else {
        return false
    }

    let currentRow = matrix[row]

    return col >= 0 && col < currentRow.count
}

class Matrix {
    var values: [[Int]]

    init(values: [[Int]]) {
        self.values = values
    }
}

class Cache {
    private var points: Set<Point> = []

    func exists(point: Point) -> Bool {
        return points.contains(point)
    }

    func save(point: Point) {
        points.insert(point)
    }

    func update(_ matrix: Matrix, with newTarget: Int) {
        for point in points {
            matrix.values[point.row][point.col] = newTarget
        }
    }
}

struct Point: Hashable {
    let row: Int
    let col: Int
}
