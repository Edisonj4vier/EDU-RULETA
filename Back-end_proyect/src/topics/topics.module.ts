import { Module } from '@nestjs/common';
import { TopicsService } from './topics.service';
import { TopicsController } from './topics.controller';
import { Topic } from './entities/topic.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';

@Module({
  controllers: [TopicsController],
  providers: [TopicsService],
  imports: [ConfigModule, TypeOrmModule.forFeature([Topic])],
})
export class TopicsModule {}
