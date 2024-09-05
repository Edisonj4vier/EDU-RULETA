import { Module } from '@nestjs/common';
import { TopicsService } from './topics.service';
import { TopicsController } from './topics.controller';
import { Topic } from './entities/topic.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  controllers: [TopicsController],
  providers: [TopicsService],
  imports: [ConfigModule, TypeOrmModule.forFeature([Topic]), AuthModule],
  exports: [TypeOrmModule],
})
export class TopicsModule {}
