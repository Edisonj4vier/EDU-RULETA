import { Module } from '@nestjs/common';
import { QuestionsService } from './questions.service';
import { QuestionsController } from './questions.controller';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Question } from './entities/question.entity';
import { Answer } from './entities/answer.entity';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  controllers: [QuestionsController],
  providers: [QuestionsService],
  imports: [
    ConfigModule,
    TypeOrmModule.forFeature([Question, Answer]),
    AuthModule,
  ],
  exports: [TypeOrmModule],
})
export class QuestionsModule {}
