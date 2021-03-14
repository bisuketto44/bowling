require_relative "../../lib/bowling"

describe "ボウリングのスコア計算" do
    before do
        @game = Bowling.new
    end
    describe "全体の合計" do
        context "すべての投球がガターだった場合" do
            it "0になること" do
                add_many_scores(20,0)
                
                #合計の計算
                @game.calc_score
                expect(@game.total_score).to eq 0
            end
        end
        
        context "すべての投球で1ピンずつ倒した場合" do
            it "20になること" do
                add_many_scores(20,1)
                
                #合計の計算
                @game.calc_score
                expect(@game.total_score).to eq 20
            end
        end
        
        context "スペアを取った場合" do
            it "スペアボーナスが加算されること" do
                
                #第一フレームで3点からの7点でスペア
                @game.add_score(3)
                @game.add_score(7)
                
                #第二フレームの一投目で4点、以降すべてガター
                @game.add_score(4)
                add_many_scores(17,0)
                
                #合計の計算
                @game.calc_score
                
                #期待する計算結果は、3+7+4+(4)=18/(4)はスペアボーナス
                expect(@game.total_score).to eq 18
            end
        end
        
        context "フレーム違いでスペアになるようなスコアだった場合" do
            it "スペアボーナスが加算されないこと" do
                
                #第一フレームで3点、5点
                @game.add_score(3)
                @game.add_score(5)
                
                #第二フレームで5点,4点
                @game.add_score(5)
                @game.add_score(4)
                
                #以降すべれガター
                add_many_scores(16,0)
                
                #合計の計算
                @game.calc_score
                
                #期待する計算結果は 3+5+5+4=17
                expect(@game.total_score).to eq 17
            end
        end
        
        context "最終フレームでスペアを取った場合" do
        it "スペアボーナスが加算されないこと" do
            
            #第一フレームで3点,7点のスペア
            @game.add_score(3)
            @game.add_score(7)
            
            #第二フレームの一投目で4点
            @game.add_score(4)
            
            #その後15投はガター
            add_many_scores(15,0)
            
            #最終フレームで3点,7点のスペア
            @game.add_score(3)
            @game.add_score(7)
            
            #合計の計算
            @game.calc_score
            
            #期待する計算結果 3+7+4+(4)+3+7 = 28
            expect(@game.total_score).to eq 28
        end
      end
      
      context "ストライクを取った場合" do
          it "ストライクボーナスが加算" do
              
            #第一フレームでストライク
            @game.add_score(10)
            
            #第二フレームで5,4
            @game.add_score(5)
            @game.add_score(4)
            
            #以降ガター
            add_many_scores(16,0)
            
            #合計
            @game.calc_score
            
            #期待 10+5+(5)+4+(4) = 28
            expect(@game.total_score).to eq 28
          end
      end
      
      context "ダブル取った場合" do
          it "それぞれのストライクボーナスを加算" do
              
              #第一フレームでストライク
              @game.add_score(10)
              #第二もストライク
              @game.add_score(10)
              #第三フレームは5,4
              @game.add_score(5)
              @game.add_score(4)
              #以降ガター
              add_many_scores(14,0)
              #合計
              @game.calc_score
              #期待 10+10+(10)+5+(5+5)+4+(4) = 53
              expect(@game.total_score).to eq 53
          end
      end
      
      context "ターキーを取った場合" do
          it "それぞれのストライクボーナスを加算" do
              
              #第一でストライク
              @game.add_score(10)
              #第二も
              @game.add_score(10)
              #第三も
              @game.add_score(10)
              #第四は5,4
              @game.add_score(5)
              @game.add_score(4)
              #以降ガター
              add_many_scores(12,0)
              #合計
              @game.calc_score
              #期待 10 10 (10) 10 (10+10) 5 (5+5) 4 (4) = 83
              expect(@game.total_score).to eq 83
          end
      end
      
      context "最終フレームでストライク取った" do
          it "ストライクボーナスが加算されない" do
              
              #第一ストライク
              @game.add_score(10)
              #第2　5,4
              @game.add_score(5)
              @game.add_score(4)
              #3~9ガター
              add_many_scores(14,0)
              #最終でストライク
              @game.add_score(10)
              #合計
              @game.calc_score
              #期待 10 5 (5) 4 (4) 10 = 38
              expect(@game.total_score).to eq 38
          end
      end
    end
end

 describe "フレームごとの合計" do
    before do
        @game = Bowling.new
    end
          context "すべての投球で１ピンずつ倒した場合" do
              it "１フレーム目の合計が２になること" do
                  add_many_scores(20,1)
                  
                  #合計を計算
                  @game.calc_score
                  expect(@game.frame_score(1)).to eq 2
              end
          end
          
          context "スペアを取った場合" do
              it "スペアボーナスが加算さええること" do
                  #第一フレームで3,7
                  @game.add_score(3)
                  @game.add_score(7)
                  #第2フレーム目は4点
                  @game.add_score(4)
                  add_many_scores(17,0)
                  @game.calc_score
                  #期待する合計は14
                  expect(@game.frame_score(1)).to eq 14
              end
          end
          
          context "ストライクを取った場合" do
              it "ストライクボーナスが加算されること" do
                  #第一フレームでストライク
                  @game.add_score(10)
                  #第二フレームで5点4点
                  @game.add_score(5)
                  @game.add_score(4)
                  #以降ガター
                  add_many_scores(16,0)
                  @game.calc_score
                  expect(@game.frame_score(1)).to eq 19
                  
              end
          end
      end



private

def add_many_scores(count,pins)
    count.times do
        @game.add_score(pins)
    end
end