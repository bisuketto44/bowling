#bowling score management class
class Bowling
    
    def initialize
        @total_score = 0
        @scores =[] #全体スコアの保存
        @temp = [] #一時保存用
        @frame_score = [] #フレームごとの合計を格納
    end
    
    def total_score
        @total_score
    end
    
    #スコアの追加
    def add_score(pins)
        @temp.push(pins)
        if @temp.size == 2 || strike?(@temp) #2回投げたら@scoresに追加して初期化 or ストライクなら
            @scores.push(@temp) #2次元配列になっている
            @temp = []
        end
    end
    
    #指定したフレームの時点でのスコア合計を返す
    def frame_score(frame)
        @frame_score[frame-1]
    end

    
    
    def calc_score
        @scores.each.with_index(1) do |score,index|#indexには縦の配列が入る
            
            #もし最終フレーム以外でのストライクならスコアにボーナスを加算して計算
            if strike?(score) && not_last_frame?(index)
                @total_score += calc_strike_bonus(index)
                
                
            #もし最終フレーム以外でのスペアならスコアニボーナスを含めて計算    
            elsif spare?(score) && not_last_frame?(index)
                @total_score += calc_spare_bonus(index)
                
            #それ以外は普通に計算
            else
                @total_score += score.inject(:+)
            end
            #合計をフレームごとに記録しておく(配列で保管)
            @frame_score.push(@total_score)

        end
    end
    
    
    #########################################################################
    
    private
    #スペアかどうかを判定する
    def spare?(score)
        score.inject(:+) == 10
    end
    
    #最終フレーム以外かどうかを判定する
    def not_last_frame?(index)
        index < 10
    end
    
    #スペアボーナスを含んだ値でスコアを計算する
    def calc_spare_bonus(index)
        10 + @scores[index].first
    end
    
    def strike?(score)
        score.first == 10
    end
    
    #ストライクボーナスを含んで計算
    def calc_strike_bonus(index)
        
        #次のフレームもストライクかつ最終フレーム以外なら、もうひとつ卯木のフレームの一投目をボーナスの対象にする
        if strike?(@scores[index]) && not_last_frame?(index + 1)
            20 + @scores[index + 1].first
        else
            10 + @scores[index].inject(:+)
        end
    end
    
  
end